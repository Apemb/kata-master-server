<template>
  <section class="section">

    <div class="columns is-mobile">
      Welcome {{userName}}
    </div>

  </section>
</template>

<script>
export default {
  name: 'HomePage',
  computed: {
    userName () {
      return this.$store.state.auth.currentUser.name
    }
  }
}
</script>
