defmodule Server.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :id,
             :name,
             :description,
             :price,
             :quantity,
             :image_url,
             :inserted_at,
             :updated_at
           ]}

  schema "items" do
    field(:name, :string)
    field(:description, :string)
    field(:price, :decimal)
    field(:quantity, :integer)
    field(:image_url, :string)

    timestamps(type: :utc_datetime)
  end

  def changeset(item, params \\ %{}) do
    item
    |> cast(params, [:name, :description, :price, :quantity, :image_url])
    |> validate_required([:name, :description, :price, :quantity])
    |> validate_number(:price, greater_than: 0)
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
  end
end
