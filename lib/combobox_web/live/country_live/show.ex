defmodule ComboboxWeb.CountryLive.Show do
  use ComboboxWeb, :live_view

  alias Combobox.Territory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"country_code" => country_code}, url, socket) do
    current_path = URI.parse(url).path
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:country, Territory.get_country!(country_code))
     |> assign(:current_path, current_path)}
  end

  defp page_title(:show), do: "Show Country"
  defp page_title(:edit), do: "Edit Country"
end
