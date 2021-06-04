<template>
  <div id="demo">
    <vue-metamask @onComplete="onComplete" />
    <div v-if="userData">
      <label>Wallet address:</label>{{ userData.metaMaskAddress }}
    </div>
    <button @click="saveFile()">Submit IPFS</button>
    <p />
    <label>TokenId</label>
    <input v-model="token.ipfsMetadataUrl" placeholder="Url property json" />
    <input v-model="token.id" type="number" />
    <button @click="registerProperty()">Register property</button>
    <p />
    <button @click="createAuction(1,token.id)">Create Auction</button>
    <input v-model="token.id" type="number" />
    <p />
    <button @click="cancelAuction(1)">Cancel Auction</button>
    <p />
    <button @click="getAuction(1)">Get Auction</button>
    <p>{{auctionData}}</p>
    <p />
    <button @click="bid(2,1.1)">BID</button>
    <p />
    <button @click="getTokensOfUser()">getTokensOfUser</button>
    
  </div>
</template>
<script>
import VueMetamask from 'vue-metamask'
import { createAlchemyWeb3 } from '@alch/alchemy-web3'
import contract from '../../contract/build/contracts/Auction.json'
export default {
  components: {
    VueMetamask,
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
