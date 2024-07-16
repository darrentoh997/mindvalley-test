<template>
  <header class="relative top-0 bg-primary shadow-lg">
    <nav class="container flex flex-row items-center text-white py-6">
      <div class="flex items-center grow">
        <!-- <i class="fa-solid fa-splotch text-2xl"></i>
        <p class="text-2xl"> Sparkle</p> -->
        <router-link :to="{ name: 'home' }">
          <a class="text-1xl font-semibold"> Products</a>
        </router-link>
      </div>

      <div class="relative">
        <router-link :to="{ name: 'checkout' }">
          <a class="fa-solid fa-cart-shopping">
            <div
              v-if="hasProductQuantity"
              class="w-4 h-4 text-xs text-white rounded-full bg-red-500 flex items-center justify-center font-mono text-center absolute -right-3 -bottom-1"
            >
              {{ totalCartProduct }}
            </div>
          </a>
        </router-link>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { computed } from "vue";
const props = defineProps({
  totalCartProduct: Number,
});

const hasProductQuantity = computed(() => {
  return props.totalCartProduct > 0;
});
</script>