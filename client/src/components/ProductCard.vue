<template>
  <div class="bg-white">
    <div>
      <div
        class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-55 lg:h-80"
      >
        <img
          :src="product.image_url"
          class="h-full w-full object-cover object-center lg:h-full lg:w-full"
        />
      </div>
      <div class="mt-4">
        <div class="w-full flex">
          <h3 class="grow text-sm text-gray-700 text-ellipsis overflow-hidden">
            <a :href="product.href">
              {{ product.name }}
            </a>
          </h3>
          <p class="text-sm font-medium text-gray-900">
            RM{{ formattedPrice }}
          </p>
        </div>

        <p class="mt-1 text-sm text-gray-500 text-ellipsis line-clamp-1">
          {{ product.description }}
        </p>
      </div>
      <div v-if="addedToCart" class="flex items-center flex-row">
        <button
          class="bg-red-100 hover:bg-red-200 text-gray-800 font-semibold py-2 px-4 flex border border-gray-300 rounded-l-lg"
          @click="$emit('remove-cart', product)"
        >
          -
        </button>
        <input
          type="text"
          class="bg-gray-50 border border-gray-300 text-gray-900 text-sm p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white grow w-0 text-center"
          disabled
          :value="cartProductQuantity"
        />
        <button
          :disabled="canAdd()"
          class="bg-green-100 hover:bg-green-200 text-gray-800 font-semibold py-2 px-4 border border-gray-300 rounded-r-lg disabled:bg-gray-200"
          @click="$emit('add-cart', product)"
        >
          +
        </button>
      </div>
      <div v-else-if="product.quantity == 0" class="py-2 rounded">
        <span class="text-red-500 font-semibold">OUT OF STOCK</span>
      </div>
      <button
        v-else
        class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow"
        @click="$emit('add-cart', product)"
      >
        Add to Bag
      </button>
    </div>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { formatDecimalsAndThousands } from "@/utils/formatPrice";
const props = defineProps({
  product: Object,
  cartProductQuantity: Number,
});

const addedToCart = computed(() => {
  return props.cartProductQuantity > 0;
});

const formattedPrice = computed(() => {
  return formatDecimalsAndThousands(props.product.price, 2);
});

const canAdd = () => {
  return props.cartProductQuantity >= props.product.quantity;
};
</script>