defmodule Server.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Server.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: 42,
        quantity: 42
      })
      |> Server.Items.create_item()

    item
  end

  def items_fixture(count, attrs_list \\ []) do
    Enum.map(1..count, fn i ->
      attrs = Enum.at(attrs_list, i - 1, %{})
      item_fixture(attrs)
    end)
  end
end
