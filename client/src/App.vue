<template>
  <div>
    <NavBar :totalCartProduct="cartStore.totalQuantity" />
    <RouterView />
  </div>
</template>

<script setup>
import { RouterView } from "vue-router";
import NavBar from "./components/NavBar.vue";
import { useCartStore } from "@/stores/cart";

const cartStore = useCartStore();
</script>

<style lang="scss" scoped>
</style>