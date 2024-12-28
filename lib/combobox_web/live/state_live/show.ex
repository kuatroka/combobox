defmodule ComboboxWeb.StateLive.Show do
  use ComboboxWeb, :live_view

  alias Combobox.Territory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"code" => code}, url, socket) do
    current_path = URI.parse(url).path
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:current_path, current_path)
     |> assign(:state, Territory.get_state!(code))}
  end

  defp page_title(:show), do: "Show State"
  defp page_title(:edit), do: "Edit State"
end
