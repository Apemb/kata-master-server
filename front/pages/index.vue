<template>
  <section class="section">
    <div class="columns is-mobile">
      Welcome to Kata Master Server
    </div>
    <b-button @click="startLogin">Click Me</b-button>

  </section>
</template>

<script>
export default {
  name: 'HomePage',
  methods: {
    startLogin () {
      // eslint-disable-next-line no-undef
      window.location.href = 'https://github.com/login/oauth/authorize?client_id='
    }
  }
}
</script>
