defmodule ComboboxWeb.TerritoryListLive.Index do
  use ComboboxWeb, :live_view

  alias Combobox.Territory
  import ComboboxWeb.TerritorySearchModalComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:search_results, [])
     |> assign(:selected_index, 0)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
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



  def handle_event("change", %{"search" => %{"query" => query}}, socket) when byte_size(query) > 0 do
    search_results = Territory.search_territories(query)
    {:noreply, assign(socket, :search_results, search_results)}
  end

  def handle_event("change", _params, socket) do
    {:noreply, assign(socket, :search_results, [])}
  end

  def handle_event("handle_key", %{"key" => "ArrowDown"}, socket) do
    new_index = min(socket.assigns.selected_index + 1, length(socket.assigns.search_results) - 1)
    {:noreply, assign(socket, :selected_index, new_index)}
  end

  def handle_event("handle_key", %{"key" => "ArrowUp"}, socket) do
    new_index = max(socket.assigns.selected_index - 1, 0)
    {:noreply, assign(socket, :selected_index, new_index)}
  end

  def handle_event("handle_key", %{"key" => "Enter"}, socket) do
    if selected_territory = Enum.at(socket.assigns.search_results, socket.assigns.selected_index) do
      {:noreply,
       socket
       |> push_navigate(to: ~p"/#{selected_territory.category}/#{selected_territory.code}")}
    else
      {:noreply, socket}
    end
  end

  def handle_event("handle_key", _key, socket) do
    {:noreply, socket}
  end

  def show_search_modal do
    JS.show(to: "#territory-searchbar-dialog")
    |> JS.show(to: "#territory_searchbox_container")
    |> JS.focus(to: "#territory-search-input")
  end

  def close_search_modal do
    JS.hide(to: "#territory-searchbar-dialog")
    |> JS.hide(to: "#territory_searchbox_container")
  end
end
