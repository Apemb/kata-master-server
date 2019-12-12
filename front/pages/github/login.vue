<template>
  <section class="section">
  </section>
</template>

<script>
export default {
  name: 'Github/login',
  mounted () {
    const code = this.$route.query.code
    return this.$store.dispatch('auth/exchangeCode', { code })
      .then(() => this.$store.dispatch('auth/getCurrentUser'))
      .then(() => {
        this.$router.push({ name: 'welcome' })
      })
  }
}
</script>
