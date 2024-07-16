defmodule ServerWeb.ItemsJSON do
  alias Server.Items.Item

  def index(%{items: items}) do
    %{data: for(quote <- items, do: data(quote))}
  end

  defp data(%Item{} = datum) do
    %{
      name: datum.name,
      description: datum.description,
      price: datum.price,
      quantity: datum.quantity
    }
  end
end
