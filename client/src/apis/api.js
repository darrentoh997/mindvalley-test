import axios from 'axios'

const localRoute = "http://localhost:4000/api/"

export const useAxios = axios.create({
  baseURL: localRoute,
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json'
  }
});

export async function getItemsData() {
  try {
    const response = await useAxios.get('/items/list');
    return response.data;
  } catch (error) {
    console.error('Error fetching items:', error);
    throw error;
  }
}

export async function checkout(cart) {
  try {
    const response = await useAxios.post('/items/checkout', { items: cart });
    return response.data;
  } catch (error) {
    console.error('Error checkout:', error);
    throw error;
  }
}