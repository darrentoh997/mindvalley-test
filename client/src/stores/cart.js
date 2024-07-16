import { defineStore } from 'pinia'
import { checkout } from '@/apis/api'

export const useCartStore = defineStore('cart', {
  state: () => {
    return { cart: [], totalQuantity: 0 }
  },
  getters: {
    cartTotalPrice(state) {
      let price = 0
      state.cart.forEach((product) => {
        price += Number(product.price) * Number(product.quantity)
      })

      return price.toFixed(2)
    },
  },
  actions: {
    addCart(product) {
      let item = this.cart.find(i => i.id === product.id)

      if (item) {
        item.quantity++
      } else {
        this.cart.push({ ...product, quantity: 1, stock: product.quantity })
      }

      this.totalQuantity++
    },

    removeCart(product) {
      let item = this.cart.find(i => i.id === product.id)

      if (item) {
        item.quantity--
      }

      if (item.quantity < 1) {
        this.cart = this.cart.filter(i => i.id != product.id)
      }

      this.totalQuantity--
    },

    getProductQuantity(product) {
      const item = this.cart.find(i => i.id === product.id)

      if (item) return item.quantity
      else return 0
    },

    async purchase() {
      await checkout(this.cart)

      // clear the cart
      this.cart = []
      this.totalQuantity = 0
    }
  },
})