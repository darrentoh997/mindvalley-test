defmodule ServerWeb.ItemsController do
  use Phoenix.Controller, formats: [:json]
  alias Server.Items

  def list(conn, _params) do
    case Items.list_items() do
      {:ok, items} ->
        json(conn, items)

      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Failed to fetch items", reason: reason})
    end
  end

  def checkout(conn, %{"items" => items}) do
    case Items.checkout_items(items) do
      :ok ->
        json(conn, %{message: "Checkout successful"})

      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Failed to checkout", reason: reason})
    end
  end
end
