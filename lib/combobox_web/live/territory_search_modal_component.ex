defmodule ComboboxWeb.TerritorySearchModalComponent do
  use ComboboxWeb, :live_component

  def mount(socket) do
    search_term =
      case Map.fetch(socket.assigns, :search_term) do
        {:ok, term} -> term
        :error -> "Search term not available yet"
      end

    modal_open =
      case Map.fetch(socket.assigns, :modal_open) do
        {:ok, open} -> open
        :error -> false
      end

    IO.puts("Modal Component Mounting with search_term: #{search_term}, modal_open: #{modal_open}")
    {:ok, socket}
  end

  def update(assigns, socket) do
    IO.puts("Modal Component Updating with search_term: #{assigns.search_term}, modal_open: #{assigns.modal_open}, search_results: #{inspect(assigns.search_results)}")
    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    ~H"""
    <div class="territory-modal" id="myModal" phx-click="close_modal" phx-window="click" phx-target={@myself}>
      <div class="modal-content" phx-click="stop_propagation">
        <span class="close" phx-click-away="close_modal">&times;</span>
        <p>Search Term: <%= @search_term %></p>
        <%!-- <p>Modal Open: <%= inspect(@modal_open) %></p> --%>
        <div>
          <%= if @modal_open do %>
            <p>Modal is open!</p>
            <input type="text"
                    phx-change="update_search_term"
                    value={@search_term}
                    placeholder="Type your search query here..." />
            <h3>Search Results:</h3>
            <ul>
              <%= for territory <- @search_results do %>
                <li><%= territory.territory_name %> - <%= territory.territory_category %></li>
              <% end %>
            </ul>
          <% else %>
            <p>Modal is closed.</p>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("stop_propagation", _params, socket) do
    {:noreply, socket}
  end
end
