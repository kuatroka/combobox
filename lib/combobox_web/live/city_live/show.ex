defmodule ComboboxWeb.CityLive.Show do
  use ComboboxWeb, :live_view

  alias Combobox.Territory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id},url, socket) do
    current_path = URI.parse(url).path
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:city, Territory.get_city!(id))
     |> assign(:current_path, current_path)}
  end

  defp page_title(:show), do: "Show City"
  defp page_title(:edit), do: "Edit City"
end
