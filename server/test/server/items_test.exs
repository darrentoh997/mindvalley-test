defmodule Server.ItemsTest do
  use Server.DataCase

  alias Server.Items

  describe "items" do
    alias Server.Items.Item

    import Server.ItemsFixtures

    @invalid_attrs %{name: nil, description: nil, price: nil, quantity: nil}

    test "list_items returns all items" do
      item = item_fixture()
      assert Items.list_items() == {:ok, [item]}
    end

    test "get_item! with invalid data returns the item with given id" do
      assert_raise Ecto.NoResultsError, fn ->
        Items.get_item!(-1)
      end
    end

    test "get_item! returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "checkout items with sufficient quantity" do
      [item1, item2] = items_fixture(2)
      initial_quantity1 = item1.quantity
      initial_quantity2 = item2.quantity

      items = [
        %{"id" => item1.id, "quantity" => initial_quantity1 - 1},
        %{"id" => item2.id, "quantity" => initial_quantity2 - 1}
      ]

      assert Items.checkout_items(items) == :ok

      updated_item1 = Repo.get!(Item, item1.id)
      updated_item2 = Repo.get!(Item, item2.id)

      assert updated_item1.quantity == 1
      assert updated_item2.quantity == 1
    end

    test "checkout items with insufficient quantity" do
      [item1, item2] = items_fixture(2)
      initial_quantity1 = item1.quantity
      initial_quantity2 = item2.quantity

      items = [
        %{"id" => item1.id, "quantity" => initial_quantity1 + 1},
        %{"id" => item2.id, "quantity" => initial_quantity2 + 1}
      ]

      assert Items.checkout_items(items) ==
               {:error, "Not enough quantity available for item with id #{item1.id}"}

      updated_item1 = Repo.get!(Item, item1.id)
      updated_item2 = Repo.get!(Item, item2.id)

      assert updated_item1.quantity == initial_quantity1
      assert updated_item2.quantity == initial_quantity2
    end

    test "create_item with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item with valid data updates the item" do
      item = item_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        price: 43,
        quantity: 43
      }

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.name == "some updated name"
      assert item.description == "some updated description"
      assert Decimal.equal?(item.price, Decimal.new("43"))
      assert item.quantity == 43
    end

    test "update_item with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
