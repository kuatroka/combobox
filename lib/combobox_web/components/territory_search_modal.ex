defmodule ComboboxWeb.TerritorySearchModal do
  use ComboboxWeb, :live_component

  alias Combobox.Territory

  def render(assigns) do
    ~H"""
    <div id={@id} class="relative z-50" aria-labelledby="modal-title" role="dialog" aria-modal="true">
      <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"></div>
      <div class="fixed inset-0 z-50 w-screen overflow-y-auto">
        <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
          <div class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
            <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
              <div class="w-full">
                <form phx-submit="search" phx-target={@myself}>
                  <input
                    type="text"
                    name="q"
                    value={@query}
                    placeholder="Search territories..."
                    class="w-full px-4 py-2 border rounded-lg"
                    phx-keyup="suggest"
                    phx-target={@myself}
                    autocomplete="off"
                  />
                </form>

                <%= if @results != [] do %>
                  <div class="mt-4">
                    <ul class="divide-y divide-gray-200">
                      <%= for result <- @results do %>
                        <li class="py-2">
                          <div class="flex justify-between">
                            <span class="font-medium"><%= result.name %></span>
                            <span class="text-gray-500"><%= result.code %></span>
                          </div>
                          <div class="text-sm text-gray-500">
                            Category: <%= result.category %>
                          </div>
                        </li>
                      <% end %>
                    </ul>
                  </div>
                <% end %>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
              <button
                type="button"
                class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
                phx-click="close"
                phx-target={@myself}
              >
                Close
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(socket) do
    {:ok, assign(socket, query: "", results: [])}
  end

  def handle_event("suggest", %{"value" => query}, socket) do
    results =
      if String.length(query) >= 2 do
        Territory.search_territories(query)
      else
        []
      end

    {:noreply, assign(socket, results: results, query: query)}
  end

  def handle_event("close", _, socket) do
    {:noreply, push_event(socket, "close-modal", %{})}
  end
end
