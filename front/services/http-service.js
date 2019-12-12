import axios from 'axios'

export default class HttpService {
  constructor ({ token } = {}) {
    const headers = {
      'Accept': 'application/json'
    }
    if (token) {
      headers.Authorization = `Bearer ${token}`
    }

    this.instance = axios.create({
      baseURL: 'http://localhost:4000/api',
      headers
    })
  }

  get ({ path, params }) {
    return this.instance
      .get(path, { params })
      .then((response) => {
        return response.data
      })
  }

  post ({ path, data }) {
    return this.instance
      .post(path, data)
      .then((response) => {
        return response.data
      })
  }
}
