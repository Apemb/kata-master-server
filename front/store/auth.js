import HttpService from '../services/http-service'

export const state = () => ({
  isLoading: false,
  token: null,
  currentUser: null
})

export const mutations = {
  saveToken (state, { token }) {
    state.token = token
  },
  saveCurrentUser (state, { user }) {
    state.currentUser = user
  },
  startLoading (state) {
    state.isLoading = true
  },
  stopLoading (state) {
    state.isLoading = false
  }
}

export const actions = {
  exchangeCode ({ commit, state }, { code }) {
    const httpInstance = new HttpService()
    const path = '/login'
    const data = { code }

    commit('startLoading')
    return httpInstance
      .post({ path, data })
      .then(({ token }) => {
        commit('saveToken', { token })
        commit('stopLoading')
      }).catch((error) => {
        console.error(error)
        commit('stopLoading')
      })
  },
  getCurrentUser ({ commit, state }) {
    const httpInstance = new HttpService({ token: state.token })
    const path = '/users/me'

    commit('startLoading')
    return httpInstance
      .get({ path })
      .then((user) => {
        commit('saveCurrentUser', { user })
        commit('stopLoading')
      }).catch((error) => {
        console.error(error)
        commit('stopLoading')
      })
  }
}
