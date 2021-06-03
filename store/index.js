export const state = () => ({
  properties: [],
})

export const mutations = {
  SET_PROPERTIES(state, payload) {
    state.properties = payload
  },
}

export const actions = {
  async getProperties({ commit }) {
    const properties = await this.$axios.get('/posts')
    commit('SET_PROPERTIES', properties.data)
  },
}
