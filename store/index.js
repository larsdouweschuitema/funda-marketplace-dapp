export const state = () => ({
  searchInputValue: '',
  properties: [],
  isModalVisible: false,
})

export const mutations = {
  SET_SEARCH_INPUT_VALUE(state, payload) {
    state.searchInputValue = payload
  },
  SET_PROPERTIES(state, payload) {
    state.properties = payload
  },
  SET_MODAL_VISIBILITY(state, payload) {
    state.isModalVisible = payload
  },
}