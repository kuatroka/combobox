defmodule ComboboxWeb.TerritorySearchLive do
  use ComboboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl">
      <h1 class="text-2xl font-bold mb-4">Search with modal</h1>

      <.modal id="territory-search-modal" show>
        <.live_component
          module={ComboboxWeb.TerritorySearchModalComponent}
          id="territory-search-component" />
      </.modal>

      <button
        phx-click={JS.show(to: "#territory-search-modal")}
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      >
        Search Territories
      </button>
    </div>
    </div>
    """
  end
end
