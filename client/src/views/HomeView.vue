<template>
  <div>
    <main>
      <div class="container sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8">
        <h2 class="text-2xl font-bold tracking-tight text-gray-900">Popular</h2>

        <div
          class="mt-6 grid grid-cols-2 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8 z-1"
        >
          <div
            v-for="product in products"
            :key="product.id"
            class="group relative"
          >
            <ProductCard
              :product="product"
              :cartProductQuantity="cartStore.getProductQuantity(product)"
              v-on:add-cart="addCart(product)"
              v-on:remove-cart="removeCart(product)"
            />
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { computed, onMounted } from "vue";
import ProductCard from "@/components/ProductCard.vue";
import { useCartStore } from "@/stores/cart";
import { useItemStore } from "@/stores/item";

const cartStore = useCartStore();
const itemStore = useItemStore();

const products = computed(() => {
  return itemStore.items;
});

function addCart(product) {
  cartStore.addCart(product);
}

function removeCart(product) {
  cartStore.removeCart(product);
}

onMounted(() => {
  itemStore.getItems();
});
</script>

<style lang="scss" scoped></style>