# lib/combobox_web/live/territory_live/search_component.ex
defmodule ComboboxWeb.TerritoryLive.SearchComponent do
  use ComboboxWeb, :live_component

  alias Combobox.Territory
  alias Combobox.Repo

  # Define all attributes first
  attr :territories, :list, required: true
  attr :territory, :map, required: true
  attr :id, :string, required: true
  attr :show, :boolean, default: false
  attr :on_cancel, JS, default: %JS{}
  attr :rest, :global
  slot :inner_block, required: true


  # Then define all functions
  @impl true
  def render(assigns) do
    ~H"""
    <div >
    <div class="border rounded-xl shadow-sm p-6 dark:bg-neutral-800 dark:border-neutral-700">
    <div id="json-example-with-tab-filter-in-dropdown-tab-preview-markup" class="max-w-sm">
    <!-- SearchBox -->
    <div class="relative" data-hs-combo-box='{
      "groupingType": "default",
      "isOpenOnFocus": true,
      "apiUrl": "https://fakestoreapi.com/products",
      "apiGroupField": "category",
      "outputItemTemplate": "<div class=\"cursor-pointer p-2 space-y-0.5 w-full text-sm text-gray-800 hover:bg-gray-100 rounded-lg focus:outline-none focus:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 dark:text-neutral-200 dark:focus:bg-neutral-700\" data-hs-combo-box-output-item><div class=\"flex justify-between items-center w-full\"><div data-hs-combo-box-output-item-field=\"title\" data-hs-combo-box-search-text data-hs-combo-box-value></div></div></div><span class=\"hidden hs-combo-box-selected:block\"><svg class=\"shrink-0 size-3.5 text-blue-600 dark:text-blue-500\" xmlns=\"http:.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"20 6 9 17 4 12\"></polyline></svg></span></img></div>",
      "groupingTitleTemplate": "<button type=\"button\" class=\"capitalize py-1 px-2 inline-flex items-center gap-x-2 text-sm text-nowrap rounded-md border border-gray-200 bg-white text-gray-600 shadow-sm hover:bg-gray-50 focus:outline-none focus:bg-gray-100 hs-combo-box-tab-active:bg-blue-600 hs-combo-box-tab-active:border-blue-600 hs-combo-box-tab-active:focus:border-blue-600 hs-combo-box-tab-active:text-white disabled:opacity-50 disabled:pointer-events-none dark:hs-combo-box-tab-active:bg-blue-500 dark:hs-combo-box-tab-active:text-white dark:hs-combo-box-tab-active:border-blue-500 dark:hs-combo-box-tab-active:focus:border-blue-500 dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-400 dark:hover:bg-neutral-700 dark:focus:bg-neutral-700\"></button>",
      "tabsWrapperTemplate": "<div class=\"overflow-x-auto p-4 rounded-t-xl border-b border-gray-200 [&::-webkit-scrollbar]:h-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300 dark:[&::-webkit-scrollbar-track]:bg-neutral-700 dark:[&::-webkit-scrollbar-thumb]:bg-neutral-500 dark:bg-neutral-800 dark:border-neutral-700\"></div>"
    }'>
      <div class="relative">
        <div class="absolute inset-y-0 start-0 flex items-center pointer-events-none z-20 ps-3.5">
          <svg class="shrink-0 size-4 text-gray-400 dark:text-white/60" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <path d="m21 21-4.3-4.3"></path>
          </svg>
        </div>
        <input class="py-3 ps-10 pe-4 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:border-neutral-700 dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600" type="text" role="combobox" aria-expanded="false" placeholder="Type a product name" value="" data-hs-combo-box-input="">
      </div>

      <!-- SearchBox Dropdown -->
          <div class="absolute z-50 w-full bg-white rounded-xl shadow-[0_10px_40px_10px_rgba(0,0,0,0.08)] dark:bg-neutral-800" style="display: none;" data-hs-combo-box-output="">
            <div class="max-h-[300px] p-2 rounded-b-xl overflow-y-auto overflow-hidden [&::-webkit-scrollbar]:w-2 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-track]:bg-gray-100 [&::-webkit-scrollbar-thumb]:bg-gray-300 dark:[&::-webkit-scrollbar-track]:bg-neutral-700 dark:[&::-webkit-scrollbar-thumb]:bg-neutral-500 dark:bg-neutral-800" data-hs-combo-box-output-items-wrapper=""></div>
          </div>
          <!-- End SearchBox Dropdown -->
        </div>
        <!-- End SearchBox -->
      </div>
    </div>

    <%!-- preline modal --%>

<!-- End SearchBox Modal -->



    </div>
    """
  end

  def search_input(assigns) do
    ~H"""
    <div class="relative ">
      <input {@rest}
          type="text"
          class="h-12 w-full border-none focus:ring-0 pl-11 pr-4 text-gray-800 placeholder-gray-400 sm:text-sm"
          placeholder="Search the territories.."
          role="combobox"
          aria-expanded="false"
          aria-controls="options"
          value={@search}> # Use @search instead of @query
    </div>
    """
  end

  def results(assigns) do
    ~H"""
      <ul class="-mb-2 py-2 text-sm text-gray-800 flex space-y-2 flex-col" id="options" role="listbox">
        <li :if={@territories == []} id="option-none" role="option" tabindex="-1" class="cursor-default select-none rounded-md px-4 py-2 text-xl">
          No Results
        </li>

        <.link navigate={~p"/territories/#{territory.id}"} id={"territory-#{territory.id}"} :for={territory <- @territories}>
          <.result_item territory={territory} />
        </.link>
      </ul>
    """
  end

  def result_item(assigns) do
    ~H"""
      <li class="cursor-default select-none rounded-md px-4 py-2 text-xl bg-zinc-100 hover:bg-zinc-800 hover:text-white hover:cursor-pointer flex flex-row space-x-2 items-center" id={"option-#{@territory.id}"} role="option" tabindex="-1" >
        <div>
          <%= @territory.territory_name %>
          <div class="text-xs"><%= @territory.territory_category %></div>
        </div>
      </li>
    """
  end

  def search_modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      class="relative z-50 hidden"
    >
      <div id={"#{@id}-bg"} class="fixed inset-0 bg-zinc-50/90 transition-opacity" aria-hidden="true" />
      <div
        class="fixed inset-0 overflow-y-auto"
        aria-labelledby={"#{@id}-title"}
        aria-describedby={"#{@id}-description"}
        role="dialog"
        aria-modal="true"
        tabindex="0"
      >
        <div class="flex min-h-full justify-center">
          <div class="w-full min-h-12 max-w-3xl p-2 sm:p-4 lg:py-6">
            <%!-- <.focus_wrap
              id={"#{@id}-container"}
              phx-mounted={@show && show_modal(@id)}
              phx-window-keydown={hide_modal(@on_cancel, @id)}
              phx-key="escape"
              phx-click-away={hide_modal(@on_cancel, @id)}
              class="hidden relative rounded-2xl bg-white p-2 shadow-lg shadow-zinc-700/10 ring-1 ring-zinc-700/10 transition min-h-[30vh] max-h-[50vh] overflow-y-scroll"
            >
              <div id={"#{@id}-content"}>
                <%= render_slot(@inner_block) %>
              </div>
            </.focus_wrap> --%>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(socket) do
    {:ok, socket, temporary_assigns: [territories: []]}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)
      |> assign_new(:territories, fn -> [] end)
      |> assign_new(:search, fn -> "" end)
    }
  end

  @impl true
  def handle_event("do-search", %{"value" => value}, socket) do
    {:noreply,
      socket
      |> assign(:search, value)
      |> assign(:territories, Territory.search_territories(value))
    }
  end
end
