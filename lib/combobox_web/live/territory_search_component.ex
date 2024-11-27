defmodule ComboboxWeb.TerritorySearchComponent do
  use ComboboxWeb, :live_component

  alias Combobox.Repo
  alias Combobox.Territory, as: Territories
  require Logger


  import Ecto.Query

  def update(assigns, socket) do  # LiveComponents use update/2, not mount/3
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:territories, [])
     |> assign(:search_term, "")
     |> assign(:show_modal, false)}
  end


    def handle_event("toggle-modal", _params, socket) do
      {:noreply, assign(socket, :show_modal, !socket.assigns.show_modal)}
    end

    def handle_event("search", %{"search" => search_term}, socket) do

      territories =
        if String.length(search_term) > 0 do
          Repo.all(from(t in Territories, where: ilike(t.territory_name, ^"%#{search_term}%"), limit: 10))
        else
          []
        end


      {:noreply, assign(socket, territories: territories, search_term: search_term)}
    end

    def render(assigns) do
      ~H"""
      <div>  <!-- Wrap everything in a single root element -->
        <.link patch={~p"/territories"} class="text-blue-500 hover:underline">
          Manage Territories
        </.link>
        <button phx-click="toggle-modal" class="text-blue-500 hover:underline">
          Search Territories
        </button>

        <div id="search-modal" class={
          "fixed top-0 left-0 w-full h-full bg-gray-800 bg-opacity-50 z-50 overflow-y-auto overflow-x-hidden
      transition-opacity duration-300" <>
            if @show_modal, do: "", else: " hidden"
        }>
          <div class="relative top-20 mx-auto p-5 border w-full max-w-2xl shadow-lg rounded-md bg-white">
            <div class="mt-3">
              <form phx-change="search" phx-submit="search" class="flex items-center">
                <label for="simple-search" class="sr-only">Search</label>
                <div class="relative w-full">
                  <div class="absolute inset-y-0 start-0 flex items-center ps-3 pointer-events-none">
                    <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true"
  xmlns="http://www.w3.org/2000/svg"
                      fill="none" viewBox="0 0 20 20">
                      <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m
  19-4-4m0-7A7 0 1 1 1 8a7 7 0 0 1 14 0Z"/>
                    </svg>
                  </div>
                  <input
                    phx-debounce="250"
                    type="search"
                    name="search"
                    id="simple-search"
                    value={@search_term}
                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500
  focus:border-blue-500 block w-full ps-10 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400
  dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    placeholder="Search territory names..."
                    required
                  />
                </div>
              </form>
              <div class="mt-4">
                <ul>
                  <%= for territory <- @territories do %>
                    <li class="p-2 border-b border-gray-200">
                      <%= territory.territory_name %>
                    </li>
                  <% end %>
                </ul>
              </div>
              <div class="mt-4 flex justify-end">
                <button phx-click="toggle-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100
  focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.
  hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white
  dark:hover:bg-gray-600 dark:focus:ring-gray-600">
                  Close
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
      """
    end
end
