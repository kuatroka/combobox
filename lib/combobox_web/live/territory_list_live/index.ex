defmodule ComboboxWeb.TerritoryListLive.Index do
  use ComboboxWeb, :live_view

  alias Combobox.Territory
  import ComboboxWeb.TerritorySearchModalComponent

  @impl true
  def mount(params, _session, socket) do
    live_action = socket.assigns[:live_action] || :index
    socket = 
      socket
      |> assign(:search_results, [])
      |> assign(:selected_index, 0)
      |> apply_action(live_action, params)

    {:ok, socket}
  end



  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Territories list")
    |> assign(:territory_list, nil)
  end

  defp apply_action(socket, :global_search, _params) do
    socket
    |> assign(:page_title, "Search Territories")
    |> assign(:territory_list, nil)
  end

  @impl true
  def handle_info({ComboboxWeb.TerritoryListLive.FormComponent, {:saved, territory_list}}, socket) do
    {:noreply, stream_insert(socket, :territories_list, territory_list)}
  end



  def handle_event("change", %{"search" => %{"query" => query}}, socket) when byte_size(query) > 0 do
    search_results = Territory.search_territories(query)
    {:noreply,
     socket
     |> assign(:search_results, search_results)
     |> assign(:selected_index, 0)}
  end

  def handle_event("change", _params, socket) do
    {:noreply,
     socket
     |> assign(:search_results, [])
     |> assign(:selected_index, 0)}
  end

  def handle_event("handle_key", %{"key" => "ArrowDown"}, socket) do
    new_index = min(socket.assigns.selected_index + 1, length(socket.assigns.search_results) - 1)

    if selected_territory = Enum.at(socket.assigns.search_results, new_index) do
      {:noreply,
       socket
       |> assign(:selected_index, new_index)
       |> push_event("update_selected", %{id: selected_territory.code})}
    else
      {:noreply, assign(socket, :selected_index, new_index)}
    end
  end

  def handle_event("handle_key", %{"key" => "ArrowUp"}, socket) do
    new_index = max(socket.assigns.selected_index - 1, 0)

    if selected_territory = Enum.at(socket.assigns.search_results, new_index) do
      {:noreply,
       socket
       |> assign(:selected_index, new_index)
       |> push_event("update_selected", %{id: selected_territory.code})}
    else
      {:noreply, assign(socket, :selected_index, new_index)}
    end
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
    JS.show(to: "#global-search-territory-searchbar-dialog")
    |> JS.show(to: "#global-search-territory_searchbox_container")
    |> JS.focus(to: "#global-search-territory-search-input")
  end

  def close_search_modal do
    JS.hide(to: "#global-search-territory-searchbar-dialog")
    |> JS.hide(to: "#global-search-territory_searchbox_container")
    |> JS.push("close_modal")
  end

  def handle_event("close_modal", _params, socket) do
    {:noreply,
     socket
     |> assign(:search_results, [])
     |> assign(:selected_index, 0)}
  end


  def render(assigns) do
    case assigns[:live_action] do
      :index -> render_index(assigns)
      :global_search -> render_global_search(assigns)
      _ -> render_global_search(assigns)
    end
  end

  defp render_index(assigns) do
    ~H"""
    <%# ## Search modal button - centered %>
    <div class="flex justify-center my-8">
      <div class="w-96">
        <button
          type="button"
          phx-click={show_search_modal()}
          class="w-full flex items-center justify-center text-sm font-medium text-gray-900 rounded-lg px-4 lg:px-5 py-2 lg:py-2.5 ring-1 ring-gray-200 hover:bg-gray-50 focus:outline-none focus:ring-4 focus:ring-gray-100 bg-white gap-2"
        >
          <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"/>
          </svg>
          <span>Search Territories...</span>
        </button>
      </div>
    </div>

    <%# ## Search modal %>
    <.territory_search_modal 
      search_results={@search_results} 
      close_modal={close_search_modal()} 
      selected_index={@selected_index}
    />
    """
  end

  defp render_global_search(assigns) do
    ~H"""
    <button
      type="button"
      phx-click={show_search_modal()}
      class="text-sm font-medium text-gray-900 rounded-lg px-4 lg:px-5 py-2 lg:py-2.5 ring-1 ring-gray-200 hover:bg-gray-50 focus:outline-none focus:ring-4 focus:ring-gray-100 bg-white gap-2"
    >
      <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"/>
      </svg>
      <span>Search...</span>
    </button>

    <.territory_search_modal 
      search_results={@search_results} 
      close_modal={close_search_modal()} 
      selected_index={@selected_index}
    />
    """
  end
end
