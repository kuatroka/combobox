defmodule ComboboxWeb.CountryLive.Index do
  use ComboboxWeb, :live_view

  alias Combobox.Territory
  alias Combobox.Territory.Country

  @impl true
  def mount(_params, _session, socket) do
    # {:ok, stream(socket, :countries, Territory.list_countries())}
    {:ok, stream(socket, :countries, [])}
  end

  # @impl true
  # def handle_params(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end

  @impl Phoenix.LiveView
  def handle_params(params, _, socket) do
    case Territory.list_countries2(params) do
      {:ok, {countries, meta}} ->
        socket = socket
          |> assign(:meta, meta)
          |> stream(:countries, countries, reset: true)

        # Apply the action after setting up the stream
        {:noreply, apply_action(socket, socket.assigns.live_action, params)}

      {:error, _meta} ->
        {:noreply, push_navigate(socket, to: ~p"/countries")}
    end
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Country")
    |> assign(:country, Territory.get_country!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Country")
    |> assign(:country, %Country{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Countries")
    |> assign(:country, nil)
  end

  @impl true
  def handle_info({ComboboxWeb.CountryLive.FormComponent, {:saved, country}}, socket) do
    {:noreply, stream_insert(socket, :countries, country)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    country = Territory.get_country!(id)
    {:ok, _} = Territory.delete_country(country)

    {:noreply, stream_delete(socket, :countries, country)}
  end
end
