defmodule ComboboxWeb.Components.SearchModalComponent do
  use ComboboxWeb, :html

  attr :search_results, :list, default: []
  attr :close_modal, :any, default: nil
  attr :selected_index, :integer, default: 0

  def search_modal(assigns) do
    ~H"""
    <div
      id="searchbar-dialog"
      class="hidden fixed inset-0 z-50"
      role="dialog"
      aria-modal="true"
    >
      <div class="fixed inset-0 bg-zinc-400/25 backdrop-blur-sm opacity-100"></div>
      <div class="fixed inset-0 overflow-y-auto px-4 py-4 sm:py-20 sm:px-6 md:py-32 lg:px-8 lg:py-[15vh]">
        <div
          id="searchbox_container"
          class="hidden mx-auto overflow-hidden rounded-lg bg-zinc-50 shadow-xl ring-zinc-900/7.5 sm:max-w-xl"
          phx-hook="SearchBar"
        >
          <div
            role="combobox"
            aria-haspopup="listbox"
            phx-click-away={@close_modal}
            aria-expanded={length(@search_results) > 0}
          >
            <form action="" novalidate="" role="search" phx-change="change">
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
                  id="search-input"
                  name="search[query]"
                  class="flex-auto rounded-lg appearance-none bg-transparent pl-10 text-zinc-900 outline-none focus:outline-none border-slate-200 focus:border-slate-200 focus:ring-0 focus:shadow-none placeholder:text-zinc-500 focus:w-full focus:flex-none sm:text-sm [&::-webkit-search-cancel-button]:hidden [&::-webkit-search-decoration]:hidden [&::-webkit-search-results-button]:hidden [&::-webkit-search-results-decoration]:hidden pr-4"
                  style={if length(@search_results) > 0, do: "border-bottom-left-radius: 0; border-bottom-right-radius: 0; border-bottom: none"}
                  aria-autocomplete="both"
                  aria-controls="searchbox__results_list"
                  autocomplete="off"
                  autocorrect="off"
                  autocapitalize="off"
                  enterkeyhint="search"
                  spellcheck="false"
                  placeholder="Find a country..."
                  type="search"
                  value=""
                  tabindex="0"
                  phx-window-keydown={@close_modal}
                  phx-key="escape"
                />
              </div>

              <ul
                :if={length(@search_results) > 0}
                class="divide-y divide-slate-200 overflow-y-auto rounded-b-lg border-t border-slate-200 text-sm leading-6 max-h-72"
                id="searchbox__results_list"
                role="listbox"
              >
                <%= for {country, index} <- Enum.with_index(@search_results) do %>
                  <li
                    id={"#{country.country_code}"}
                    class={[
                      "block p-4 hover:bg-slate-100",
                      if(@selected_index == index, do: "bg-slate-100 text-sky-800", else: "")
                    ]}
                    role="option"
                    aria-selected={@selected_index == index}
                  >
                    <.link
                      navigate={~p"/countries/#{country.country_code}"}
                      class="block focus:outline-none"
                      tabindex={if(@selected_index == index, do: "0", else: "-1")}
                    >
                      <%= country.country_name %>
                    </.link>
                  </li>
                <% end %>
              </ul>
            </form>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
