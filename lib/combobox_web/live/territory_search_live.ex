defmodule ComboboxWeb.TerritorySearchLive do
  use ComboboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, search_term: "", modal_open: false)}
  end

  def handle_event("search", %{"value" => search_term}, socket) do
    {:noreply, assign(socket, search_term: search_term)}
  end

  def handle_event("open_modal", _params, socket) do
    IO.puts("Opening modal")
    {:noreply, assign(socket, modal_open: true)}
  end

  def handle_event("close_modal", _params, socket) do
    IO.puts("Closing modal")
    {:noreply, assign(socket, modal_open: false)}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl">
      <h1 class="text-2xl font-bold mb-4">Search with modal</h1>

      <button
        phx-click="open_modal"
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      >
        Search Territories
      </button>

      <.modal id="territory-search-modal" show={@modal_open}>
        <.live_component
          module={ComboboxWeb.TerritorySearchModalComponent}
          id="territory-search-component"
          search_term={@search_term} />
        <button phx-click="close_modal" class="close-button">Close</button>
      </.modal>
    </div>
    """
  end
end
