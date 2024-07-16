defmodule Server.Items do
  @moduledoc """
  The Items context.
  """

  import Ecto.Query, warn: false
  alias Server.Repo

  alias Server.Items.Item

  def list_items do
    try do
      items = Repo.all(Item)
      {:ok, items}
    catch
      e -> {:error, e.message}
    end
  end

  def get_item!(id), do: Repo.get!(Item, id)

  def checkout_items(items) do
    Repo.transaction(fn ->
      Enum.each(items, fn %{"id" => id, "quantity" => purchaseQuantity} ->
        item = Repo.get!(Item, id)

        if item.quantity < purchaseQuantity do
          Repo.rollback("Not enough quantity available for item with id #{id}")
        else
          item
          |> Item.changeset(%{quantity: item.quantity - purchaseQuantity})
          |> Repo.update!()
        end
      end)
    end)
    |> case do
      {:ok, _} -> :ok
      {:error, reason} -> {:error, reason}
    end
  end

  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end
end
