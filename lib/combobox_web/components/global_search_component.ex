defmodule ComboboxWeb.GlobalSearchComponent do
  use ComboboxWeb, :live_component

  alias Combobox.Territory

  def mount(socket) do
    {:ok,
     socket
     |> assign(:search_results, [])
     |> assign(:selected_index, 0)}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  def show_search_modal do
    JS.show(to: "#global-searchbar-dialog")
    |> JS.show(to: "#global_searchbox_container")
    |> JS.focus(to: "#global-search-input")
  end

  def close_search_modal do
    JS.hide(to: "#global-searchbar-dialog")
    |> JS.hide(to: "#global_searchbox_container")
    |> JS.push("close_modal")
  end

  @impl true
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

  def handle_event("close_modal", _params, socket) do
    {:noreply,
     socket
     |> assign(:search_results, [])
     |> assign(:selected_index, 0)}
  end

  def render(assigns) do
    ~H"""
    <div>
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

      <div
        id="global-searchbar-dialog"
        class="hidden fixed inset-0 z-50"
        role="dialog"
        aria-modal="true"
        phx-target={@myself}

      >
        <div class="fixed inset-0 bg-zinc-400/25 backdrop-blur-sm opacity-100"></div>
        <div class="fixed inset-0 overflow-y-auto px-4 py-4 sm:py-20 sm:px-6 md:py-32 lg:px-8 lg:py-[15vh]">
          <div
            id="global_searchbox_container"
            class="hidden mx-auto overflow-hidden rounded-lg bg-zinc-50 shadow-xl ring-zinc-900/7.5 sm:max-w-xl"
            phx-hook="SearchBar"
          >
            <div
              role="combobox"
              aria-haspopup="listbox"
              phx-click-away={close_search_modal()}
              phx-target={@myself}
              aria-expanded={length(@search_results) > 0}
            >
              <form action="" novalidate="" role="search" phx-change="change" phx-target={@myself}>
                <div class="group relative flex h-12">
                  <svg
                    viewBox="0 0 20 20"
                    fill="none"
                    aria-hidden="true"
                    class="pointer-events-none absolute left-3 top-0 h-full w-5 stroke-zinc-500"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M12.01 12a4.25 4.25 0 1 0-6.02-6 4.25 4.25 0 0 0 6.02 6Zm0 0 3.24 3.25"
                    >
                    </path>
                  </svg>

                  <input
                    id="global-search-input"
                    name="search[query]"
                    class="flex-auto rounded-lg appearance-none bg-transparent pl-10 text-zinc-900 outline-none focus:outline-none border-slate-200 focus:border-slate-200 focus:ring-0 focus:shadow-none placeholder:text-zinc-500 focus:w-full focus:flex-none sm:text-sm [&::-webkit-search-cancel-button]:hidden [&::-webkit-search-decoration]:hidden [&::-webkit-search-results-button]:hidden [&::-webkit-search-results-decoration]:hidden pr-4"
                    style={if length(@search_results) > 0, do: "border-bottom-left-radius: 0; border-bottom-right-radius: 0; border-bottom: none"}
                    aria-autocomplete="both"
                    aria-controls="global_searchbox__results_list"
                    autocomplete="off"
                    autocorrect="off"
                    autocapitalize="off"
                    enterkeyhint="search"
                    spellcheck="false"
                    placeholder="Search territories..."
                    type="search"
                    value=""
                    tabindex="0"
                    phx-window-keydown={close_search_modal()}
                    phx-key="escape"
                    phx-keydown="handle_key"
                    phx-target={@myself}
                  />
                </div>

                <ul
                  :if={length(@search_results) > 0}
                  class="divide-y divide-slate-200 overflow-y-auto rounded-b-lg border-t border-slate-200 text-sm leading-6 max-h-72"
                  id="global_searchbox__results_list"
                  role="listbox"
                >
                  <%= for {territory, index} <- Enum.with_index(@search_results) do %>
                    <li
                      id={"#{territory.code}"}
                      class={[
                        "block hover:bg-slate-100",
                        if(@selected_index == index, do: "bg-slate-100 text-sky-800", else: "")
                      ]}
                      role="option"
                      aria-selected={@selected_index == index}
                    >
                      <a
                        href={~p"/#{territory.category}/#{territory.code}"}
                        class="block p-4 focus:outline-none"
                        tabindex={if(@selected_index == index, do: "0", else: "-1")}
                        data-phx-link="redirect"
                        data-phx-link-state="push"
                      >
                        { territory.name } ({String.capitalize(territory.category)})
                      </a>
                    </li>
                  <% end %>
                </ul>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
