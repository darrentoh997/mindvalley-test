<template>
  <div class="container sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8">
    <div class="flex flex-col lg:flex-row gap-5">
      <div class="grow">
        <h2 class="text-2xl font-bold tracking-tight text-gray-900">My Cart</h2>
        <div class="mt-6">
          <div v-if="hasCart" class="flex flex-col gap-1">
            <div
              v-for="product in cartStore.cart"
              :key="product.id"
              class="relative"
            >
              <ProductList
                :cartProduct="product"
                :cartProductQuantity="cartStore.getProductQuantity(product)"
                v-on:add-cart="addCart(product)"
                v-on:remove-cart="removeCart(product)"
              />
            </div>
          </div>
          <span v-else>No items in cart</span>
        </div>
      </div>
      <div v-if="hasCart" class="shrink-0">
        <span class="text-2xl font-bold tracking-tight text-gray-900">
          Order Summary
        </span>
        <div
          class="mt-6 overflow-hidden rounded-2xl bg-white px-4 py-4 shadow flex flex-col gap-5"
        >
          <div>
            <span class="text-2xl font-bold text-gray-900"
              >Grand Total: RM {{ formattedPrice }}
            </span>
          </div>

          <div class="m-auto">
            <button
              @click="purchase()"
              class="bg-green-100 hover:bg-green-200 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
            >
              Purchase
            </button>
          </div>
        </div>
      </div>
    </div>
    <ProductList />
  </div>
</template>

<script setup>
import { computed } from "vue";
import ProductList from "@/components/ProductList.vue";
import { useCartStore } from "@/stores/cart";
import { formatDecimalsAndThousands } from "@/utils/formatPrice";

const cartStore = useCartStore();

const hasCart = computed(() => {
  return cartStore.cart.length > 0;
});

const formattedPrice = computed(() => {
  return formatDecimalsAndThousands(cartStore.cartTotalPrice, 2);
});

const addCart = (product) => {
  cartStore.addCart(product);
};

const removeCart = (product) => {
  cartStore.removeCart(product);
};

const purchase = async () => {
  await cartStore.purchase();
};
</script>

<style lang="scss" scoped>
</style>