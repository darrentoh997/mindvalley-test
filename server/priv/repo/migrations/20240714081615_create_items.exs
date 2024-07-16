defmodule Server.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add(:name, :string)
      add(:description, :string)
      add(:price, :decimal)
      add(:quantity, :integer)
      add(:image_url, :string)

      timestamps(type: :utc_datetime)
    end
  end
end
