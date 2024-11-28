defmodule ComboboxWeb.TerritorySearchLive do
  use ComboboxWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts("Mounting with modal_open: false, search_term: \"\"") # Debugging
    {:ok, assign(socket, search_term: "", modal_open: false, search_results: [])}
  end

  def handle_event("open_modal", _params, socket) do
    IO.puts("Opening modal")
    {:noreply, assign(socket, modal_open: true)}
  end

  def handle_event("close_modal", _params, socket) do
    IO.puts("Closing modal")
    {:noreply, assign(socket, modal_open: false)}
  end

  def handle_event("update_search_term", %{"value" => search_term}, socket) do
    IO.puts("Updating search term to: #{search_term}")

    # Call the search function to get results
    search_results = Combobox.Repo.all(Combobox.Territory.search(Combobox.Repo, search_term))

    IO.inspect(search_results, label: "Search Results")

    {:noreply, assign(socket, search_term: search_term, search_results: search_results)}
  end

  def render(assigns) do
    IO.puts("Rendering with modal_open: #{assigns.modal_open}, search_term: #{assigns.search_term}") # Debugging
    ~H"""
    <div class="mx-auto max-w-2xl">
      <h1 class="text-2xl font-bold mb-4">Search with modal</h1>

      <button
        phx-click="open_modal"
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      >
        Search Territories
      </button>

      <%= if @modal_open do %>
        <.modal id="territory-search-modal" show={@modal_open}>
          <div class="bg-white p-4 rounded shadow">
            Modal Content Here
            <.live_component
              module={ComboboxWeb.TerritorySearchModalComponent}
              id="territory-search-component"
              search_term={@search_term}
              modal_open={@modal_open}
              search_results={@search_results} />
            <button phx-click="close_modal" class="close-button">Close</button>
          </div>
        </.modal>
      <% end %>
    </div>
    """
  end
end
