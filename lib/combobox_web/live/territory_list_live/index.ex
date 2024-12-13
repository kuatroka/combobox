defmodule ComboboxWeb.TerritoryListLive.Index do
  use ComboboxWeb, :live_view

  alias Combobox.Territory
  alias Combobox.Territory.TerritoryList

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :territories_list, Territory.list_territories_list())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"code" => code}) do
    socket
    |> assign(:page_title, "Edit Territory list")
    |> assign(:territory_list, Territory.get_territory_list!(code))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Territory list")
    |> assign(:territory_list, %TerritoryList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Territories list")
    |> assign(:territory_list, nil)
  end

  @impl true
  def handle_info({ComboboxWeb.TerritoryListLive.FormComponent, {:saved, territory_list}}, socket) do
    {:noreply, stream_insert(socket, :territories_list, territory_list)}
  end

  @impl true
  def handle_event("delete", %{"code" => code}, socket) do
    territory_list = Territory.get_territory_list!(code)
    {:ok, _} = Territory.delete_territory_list(territory_list)

    {:noreply, stream_delete(socket, :territories_list, territory_list)}
  end
end
