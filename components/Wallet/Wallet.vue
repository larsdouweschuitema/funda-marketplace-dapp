<template>
  <div id="demo">
    <vue-metamask @onComplete="onComplete" />
    <div v-if="userData">
      <label>Wallet address:</label>{{ userData.metaMaskAddress }}
    </div>
    <UiButton @click="saveFile()">Submit IPFS</UiButton>
    <label>TokenId</label>
    <input v-model="token.ipfsMetadataUrl" placeholder="Url property json" />
    <UiButton @click="registerProperty()">Register property</UiButton>
    <UiButton @click="getAuction(1)">Get Auction</UiButton>
    <p>{{auctionData}}</p>
    <div>
      <UiButton @click="bid(2,1.1)">BID</UiButton>
    </div>
    <UiButton @click="getTokensOfUser()">getTokensOfUser</UiButton>
    <ModalPropertyBidder button-name="Create auction" :handle-click="sellProperty">
      <input v-model="token.id" type="number" placeholder="Type a value e.g. 1" />
    </ModalPropertyBidder>
  </div>
</template>
<script>
import VueMetamask from 'vue-metamask'
import { createAlchemyWeb3 } from '@alch/alchemy-web3'
import contract from '../../contract/build/contracts/Auction.json'
import { UiButton } from '@funda/ui'

export default {
  components: {
    VueMetamask,
    UiButton,
  },
  data() {
    return {
      alchWeb3: null,
      userData: null,
      decentralizedContract: null,
      token: {
        id: null,
        ipfsMetadataUrl: null,
      },
      property: null,
      existingTokens: null,
      auctionData: null
    }
  },
  async mounted() {
    await this.loadBlockchainData()
    this.getProperty(1)
  },
  methods: {
    sellProperty() {
      this.createAuction(1,this.token.id)
    },
    onComplete(responseData) {
      this.userData = responseData
    },
    loadBlockchainData() {
      const API_KEY =
        'https://eth-ropsten.alchemyapi.io/v2/OPdcrIpUthOV6OEG8MA65-C3JmNFRhRS'
      this.alchWeb3 = createAlchemyWeb3(API_KEY)
      const contractAddress = '0xF3A0F15bbF5BA6340Cf3d4295B21C32317f78db7'
      this.decentralizedContract = new this.alchWeb3.eth.Contract(
        contract.abi,
        contractAddress
      )
    },
    async registerProperty() {
      if (this.token.id == null) return
      await this.decentralizedContract.methods
        .registerKadasterProperty(
          this.userData.metaMaskAddress,
          this.token.ipfsMetadataUrl,
          this.token.id
        )
        .send({
          from: this.userData.metaMaskAddress,
        })
        .on('transactionHash')
    },
    async getProperty(tokenId){
        this.property = await this.decentralizedContract.methods
        .tokenURI(tokenId)
        .call()
        
        const property = await this.$axios.get('https://dweb.link/ipfs/QmYygiPjm9DMa7Pme1Q2LeDFsRQ14K2jNPTTfYZFD38NQy')
        this.$store.commit('SET_PROPERTIES', [property.data])
    },
    // returns a list with all tokenIds of User
    async getTokensOfUser(){
        let result = this.existingTokens = await this.decentralizedContract.methods
        .getTokensOf(this.userData.metaMaskAddress)
        .call()
        console.log(result)
    },
    async bid(auctionId, amount){
        let valueEth = this.alchWeb3.utils.toWei(String(amount), 'ether')
        await this.decentralizedContract.methods
        .bidOnAuction(auctionId)
        .send({
          from: this.userData.metaMaskAddress,
          value: valueEth
        })
        .on('transactionHash')
    },
    async createAuction(tokenId, startPrice){
        let now = new Date();
        let tms = now.setDate(now.getDate() + parseInt(1));
        let time = parseInt(tms/1000)
        let valueEth = this.alchWeb3.utils.toWei(String(startPrice), 'ether')
        await this.decentralizedContract.methods
        .createAuction(tokenId,valueEth, time)
        .send({
          from: this.userData.metaMaskAddress
        })
        .on('transactionHash')
    },
    async cancelAuction(tokenId){
        await this.decentralizedContract.methods
        .cancelAuction(tokenId)
        .send({
          from: this.userData.metaMaskAddress
        })
        .on('transactionHash')
    },
    async finalizeAuction(auctionId){
        await this.decentralizedContract.methods
        .finalizeAuction(auctionId)
        .send({
          from: this.userData.metaMaskAddress,
        })
        .on('transactionHash')
    },
    async getAuction(auctionId){
        this.auctionData = await this.decentralizedContract.methods
        .getAuctionById(auctionId)
        .call()
    }
  },
}
</script>
