// SPDX-License-Identifier: Non-Licensed
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "../node_modules/@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Context.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";


contract Auction is Context, AccessControlEnumerable, ERC721Enumerable, ERC721Burnable, ERC721Pausable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIdTracker;
    Counters.Counter private _auctionIdTracker;

    AuctionDto[] public auctions;

    struct AuctionDto {
        uint256 deadline;
        uint256 startPrice;
        string metadata;
        uint256 tokenId;
        address payable owner;
        bool active;
        bool finalized;
    }
    
    struct Bid {
        address payable from;
        uint256 amount;
    }

    // Optional mapping for token URIs
    mapping (uint256 => string) private _tokenURIs;
    mapping (uint256 => address) private _tokenCreators;


    constructor() ERC721("fundaCoin", "funda") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    // Mapping from auction index to user bids
    mapping(uint256 => Bid[]) public auctionBids;

    // Mapping from owner to a list of owned auctions
    mapping(address => uint[]) public auctionOwner;

    mapping(address => uint[]) public tokenOwner;

    function getTokensOf(address _owner) public view returns(uint[] memory) {
        uint[] memory ownedTokens = tokenOwner[_owner];
        return ownedTokens;
    }

    function getAuctionsOf(address _owner) public view returns(uint[] memory) {
        uint[] memory ownedAuctions = auctionOwner[_owner];
        return ownedAuctions;
    }

    function getCurrentBid(uint _auctionId) public view returns(uint256, address) {
        uint bidsLength = auctionBids[_auctionId].length;
        // if there are bids refund the last bid
        if( bidsLength > 0 ) {
            Bid memory lastBid = auctionBids[_auctionId][bidsLength - 1];
            return (lastBid.amount, lastBid.from);
        }
        return (uint256(0), address(0));
    }

    function getAuctionById(uint _auctionId) public view returns(
        uint256 deadline,
        uint256 startPrice,
        string memory metadata,
        uint256 tokenId,
        address payable owner,
        bool active,
        bool finalized) {

        AuctionDto memory auc = auctions[_auctionId];
        return (
            auc.deadline, 
            auc.startPrice, 
            auc.metadata, 
            auc.tokenId, 
            auc.owner, 
            auc.active, 
            auc.finalized);
    }
    
    function createAuction(uint256 _propertyId, uint256 _startPrice, uint _deadline) public virtual returns(bool) {
        string memory _tokenURI = tokenURI(_propertyId);

        uint auctionId = _auctionIdTracker.current();
        _auctionIdTracker.increment();

        AuctionDto memory newAuction;
        newAuction.deadline = _deadline;
        newAuction.startPrice = _startPrice;
        newAuction.metadata = _tokenURI;
        newAuction.tokenId = _propertyId;
        newAuction.owner = payable(msg.sender);
        newAuction.active = true;
        newAuction.finalized = false;
        
        auctions.push(newAuction);        
        auctionOwner[msg.sender].push(auctionId);
        
        emit AuctionCreated(msg.sender, auctionId);

        return true;
    }

    function approveAndTransfer(address _from, address _to,  uint256 _tokenId) internal returns(bool) {
        approve(_to, _tokenId);
        transferFrom(_from, _to, _tokenId);
        return true;
    }

    modifier isOwner(uint _auctionId) {
        require(auctions[_auctionId].owner == msg.sender);
        _;
    }

    function cancelAuction(uint _auctionId) public isOwner(_auctionId){
        AuctionDto memory myAuction = auctions[_auctionId];
        uint bidsLength = auctionBids[_auctionId].length;

        // if there are bids refund the last bid
        if( bidsLength > 0 ) {
            Bid memory lastBid = auctionBids[_auctionId][bidsLength - 1];
            if(!lastBid.from.send(lastBid.amount)) {
                revert();
            }
        }

        // approve and transfer from this contract to auction owner
        if(approveAndTransfer(msg.sender, myAuction.owner, myAuction.tokenId)){
            auctions[_auctionId].active = false;
            emit AuctionCanceled(msg.sender, _auctionId);
        }
    }

    function finalizeAuction(uint _auctionId) public {
        AuctionDto memory myAuction = auctions[_auctionId];
        uint bidsLength = auctionBids[_auctionId].length;

        _auctionIdTracker.decrement();

        // if there are no bids cancel
        if(bidsLength == 0) {
            cancelAuction(_auctionId);
        }else{

            // the money goes to the auction owner
            Bid memory lastBid = auctionBids[_auctionId][bidsLength - 1];
            if(!myAuction.owner.send(lastBid.amount)) {
                revert();
            }

            // approve and transfer from this contract to the bid winner 
            if(approveAndTransfer(msg.sender, lastBid.from, myAuction.tokenId)){
                auctions[_auctionId].active = false;
                auctions[_auctionId].finalized = true;
                emit AuctionFinalized(msg.sender, _auctionId);
            }
        }
    }

    function bidOnAuction(uint _auctionId) external payable {
        uint256 ethAmountSent = msg.value;

        // owner can't bid on their auctions
        AuctionDto memory myAuction = auctions[_auctionId];
        if(myAuction.owner == msg.sender) revert();

        // if auction is expired
        if( block.timestamp > myAuction.deadline ) revert();

        uint bidsLength = auctionBids[_auctionId].length;
        uint256 tempAmount = myAuction.startPrice;
        Bid memory lastBid;

        // there are previous bids
        if( bidsLength > 0 ) {
            lastBid = auctionBids[_auctionId][bidsLength - 1];
            tempAmount = lastBid.amount;
        }

        // check if amound is greater than previous amount  
        if( ethAmountSent < tempAmount ) revert(); 

        // refund the last bidder
        if( bidsLength > 0 ) {
            if(!lastBid.from.send(lastBid.amount)) {
                revert();
            }  
        }

        // insert bid 
        Bid memory newBid;
        newBid.from = payable(msg.sender);
        newBid.amount = ethAmountSent;
        auctionBids[_auctionId].push(newBid);
        emit BidSuccess(msg.sender, _auctionId);
    }

    event BidSuccess(address _from, uint _auctionId);

    // AuctionCreated is fired when an auction is created
    event AuctionCreated(address _owner, uint _auctionId);

    // AuctionCanceled is fired when an auction is canceled
    event AuctionCanceled(address _owner, uint _auctionId);

    // AuctionFinalized is fired when an auction is finalized
    event AuctionFinalized(address _owner, uint _auctionId);

    function _setTokenURI(uint256 tokenId, string memory _tokenURI, address creator) internal virtual {
        require(_exists(tokenId), "Master: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
        _tokenCreators[tokenId] = creator;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "Master: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        return _tokenURI;
    }

    function tokenCreator(uint256 tokenId) public view returns(address) {
        require(_exists(tokenId), "Master: URI query for nonexistent token");

        return _tokenCreators[tokenId];
    }

    //mint
    function registerKadasterProperty(address to, string memory tokenURI_, uint256 tokenId) public virtual {
        require(!_exists(tokenId), "Master: TokenId already existent");

        _tokenIdTracker.increment();

        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI_, to);
        tokenOwner[to].push(tokenId);
    }

    function totalOfMintedTokens() public view returns(string memory) {
        // return uint256 is you wish to return a BigNumber
        uint256 numberOfMintedTokens = _tokenIdTracker.current();
        return numberOfMintedTokens.toString();
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC721, ERC721Enumerable, ERC721Pausable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AccessControlEnumerable, ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}