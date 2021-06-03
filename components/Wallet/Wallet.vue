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
      userData: null,
      decentralizedBankContract: null,
      token: {
        id: null,
        ipfsMetadataUrl: null,
      },
    }
  },
  async mounted() {
    await this.loadBlockchainData()
  },
  methods: {
    onComplete(responseData) {
      this.userData = responseData
    },
    loadBlockchainData() {
      const API_KEY =
        'https://eth-ropsten.alchemyapi.io/v2/OPdcrIpUthOV6OEG8MA65-C3JmNFRhRS'
      const alchWeb3 = createAlchemyWeb3(API_KEY)
      const contractAddress = '0x780816e49CF248D07952BfAbefDeE5BCAC676C96'
      this.decentralizedBankContract = new alchWeb3.eth.Contract(
        contract.abi,
        contractAddress
      )
    },
    async registerProperty() {
      if (this.token.id == null) return
      await this.decentralizedBankContract.methods
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
  },
}
</script>
