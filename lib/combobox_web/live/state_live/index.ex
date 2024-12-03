defmodule ComboboxWeb.StateLive.Index do
  use ComboboxWeb, :live_view

  alias Combobox.Territory
  alias Combobox.Territory.State

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :states, Territory.list_states())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit State")
    |> assign(:state, Territory.get_state!(id))
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
  def handle_event("delete", %{"id" => id}, socket) do
    state = Territory.get_state!(id)
    {:ok, _} = Territory.delete_state(state)

    {:noreply, stream_delete(socket, :states, state)}
  end
end
