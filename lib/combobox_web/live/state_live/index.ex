defmodule ComboboxWeb.StateLive.Index do
  use ComboboxWeb, :live_view

  alias Combobox.Territory
  alias Combobox.Territory.State

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :states, Territory.list_states())}
  end

  @impl true
  def handle_params(params, url, socket) do
    current_path = URI.parse(url).path
    {:noreply,
     socket
     |> assign(:current_path, current_path)
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"code" => code}) do
    socket
    |> assign(:page_title, "Edit State")
    |> assign(:state, Territory.get_state!(code))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New State")
    |> assign(:state, %State{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing States")
    |> assign(:state, nil)
  end

  @impl true
  def handle_info({ComboboxWeb.StateLive.FormComponent, {:saved, state}}, socket) do
    {:noreply, stream_insert(socket, :states, state)}
  end

  @impl true
  def handle_event("delete", %{"code" => code}, socket) do
    state = Territory.get_state!(code)
    {:ok, _} = Territory.delete_state(state)

    {:noreply, stream_delete(socket, :states, state)}
  end
end
