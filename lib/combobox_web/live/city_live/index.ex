defmodule ComboboxWeb.CityLive.Index do
  use ComboboxWeb, :live_view

  alias Combobox.Territory
  alias Combobox.Territory.City

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      {:ok, 
        socket
        |> stream(:cities, Territory.list_cities())
        |> attach_hook(:handle_back, :handle_params, fn
          _params, url, socket when socket.assigns.live_action in [:new, :edit] ->
            path = URI.parse(url).path
            case path do
              "/cities" -> {:halt, push_patch(socket, to: ~p"/cities")}
              _ -> {:cont, socket}
            end
          _params, _url, socket ->
            {:cont, socket}
        end)}
    else
      {:ok, stream(socket, :cities, Territory.list_cities())}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit City")
    |> assign(:city, Territory.get_city!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New City")
    |> assign(:city, %City{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cities")
    |> assign(:city, nil)
  end

  @impl true
  def handle_info({ComboboxWeb.CityLive.FormComponent, {:saved, city}}, socket) do
    {:noreply, stream_insert(socket, :cities, city)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    city = Territory.get_city!(id)
    {:ok, _} = Territory.delete_city(city)

    {:noreply, stream_delete(socket, :cities, city)}
  end

  @impl true
  def handle_event("modal-close", _, socket) do
    {:noreply, push_navigate(socket, to: ~p"/cities")}
  end

end
