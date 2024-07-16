alias Server.Items

# Read items from the JSON file
seeds_path = "priv/repo/seeds.json"

seeds_path
|> File.read!()
|> Jason.decode!()
|> Enum.each(fn attrs ->
  # Construct an item struct and attempt to insert it
  item = %{
    name: attrs["name"],
    description: attrs["description"],
    price: attrs["price"],
    quantity: attrs["quantity"],
    image_url: attrs["image_url"]
  }

  case Items.create_item(item) do
    {:ok, _item} -> :ok
    {:error, _changeset} -> :duplicate
  end
end)
