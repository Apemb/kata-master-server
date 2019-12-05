<template>
  <section class="section">
    {{ githubToken }}
  </section>
</template>

<script>
export default {
  name: 'HomePage',
  computed: {
    githubToken () {
      console.log(this.$route)
      return this.$route.query.code
    }
  }
}
</script>
