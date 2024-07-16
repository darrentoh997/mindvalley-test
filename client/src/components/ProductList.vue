<template>
  <div
    v-if="cartProduct"
    class="relative overflow-hidden rounded-2xl bg-white px-4 py-4 shadow"
  >
    <div class="grid grid-cols-3 gap-2 lg:grid-cols-4">
      <div class="relative aspect-h-1 aspect-w-1 rounded-md bg-white">
        <img
          :src="cartProduct.image_url"
          class="h-full w-full object-cover object-center"
        />
      </div>
      <div class="col-span-2 flex flex-col overflow-hidden lg:col-span-3">
        <div>
          <h3 class="text-sm text-gray-700 text-ellipsis overflow-hidden">
            <a :href="cartProduct.href">
              {{ cartProduct.name }}
            </a>
          </h3>

          <span class="mt-1 text-sm text-gray-500 text-ellipsis line-clamp-1">
            {{ cartProduct.description }}
          </span>
        </div>
        <div class="mt-4 flex flex-wrap items-center justify-between gap-2">
          <div class="flex items-center flex-row" v-if="addedToCart">
            <button
              class="bg-red-100 hover:bg-red-200 text-gray-800 font-semibold py-2 px-4 flex border border-gray-300 rounded-l-lg"
              @click="$emit('remove-cart', cartProduct)"
            >
              -
            </button>
            <input
              type="text"
              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm p-2.5 grow w-10 text-center"
              disabled
              :value="cartProductQuantity"
            />
            <button
              :disabled="canAdd()"
              class="bg-green-100 hover:bg-green-200 text-gray-800 font-semibold py-2 px-4 border border-gray-300 rounded-r-lg disabled:bg-gray-200"
              @click="$emit('add-cart', cartProduct)"
            >
              +
            </button>
          </div>
          <button
            v-else
            class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
            @click="$emit('add-cart', cartProduct)"
          >
            Add to Bag
          </button>
          <div class="">
            <span class="text-2xl font-bold text-gray-900"
              >RM{{ formattedPrice }}</span
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { formatDecimalsAndThousands } from "@/utils/formatPrice";
const props = defineProps({
  cartProduct: Object,
  cartProductQuantity: Number,
});

const addedToCart = computed(() => {
  return props.cartProductQuantity > 0;
});
const formattedPrice = computed(() => {
  const totalPrice =
    Number(props.cartProduct.quantity) * Number(props.cartProduct.price);
  return formatDecimalsAndThousands(totalPrice.toFixed(2), 2);
});

const canAdd = () => {
  return props.cartProductQuantity >= props.cartProduct.stock;
};
</script>