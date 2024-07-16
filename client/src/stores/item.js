import { defineStore } from 'pinia'
import { getItemsData } from '@/apis/api'
export const useItemStore = defineStore('item', {
  state: () => {
    return { items: [] }
  },
  actions: {
    async getItems() {
      this.items = await getItemsData()
    },
  },
})