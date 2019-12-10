<template>
  <section class="section">
    {{ githubToken }}

    <b-button @click="getUser">Get Github User</b-button>

    {{JSON.stringify(user)}}

  </section>
</template>

<script>
export default {
  name: 'HomePage',
  data () {
    return {
      user: null
    }
  },
  computed: {
    githubToken () {
      console.log(this.$route)
      return this.$route.query.code
    }
  },
  methods: {
    async getUser () {
      this.user = await this.$axios.$post('http://localhost:4000/api/user', { code: this.githubToken })
    }
  }
}
</script>
