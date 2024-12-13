defmodule ComboboxWeb.TerritoryListLive.Show do
  use ComboboxWeb, :live_view

  alias Combobox.Territory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:territory_list, Territory.get_territory_list!(id))}
  end

  defp page_title(:show), do: "Show Territory list"
  defp page_title(:edit), do: "Edit Territory list"
end
