defmodule ComboboxWeb.StateLive.FormComponent do
  use ComboboxWeb, :live_component

  alias Combobox.Territory

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage state records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="state-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:state_id]} type="number" label="State" />
        <.input field={@form[:state_name]} type="text" label="State name" />
        <.input field={@form[:country_code]} type="text" label="Country code" />
        <.input field={@form[:code]} type="text" label="Code" />
        <:actions>
          <.button phx-disable-with="Saving...">Save State</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{state: state} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Territory.change_state(state))
     end)}
  end

  @impl true
  def handle_event("validate", %{"state" => state_params}, socket) do
    changeset = Territory.change_state(socket.assigns.state, state_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"state" => state_params}, socket) do
    save_state(socket, socket.assigns.action, state_params)
  end

  defp save_state(socket, :edit, state_params) do
    case Territory.update_state(socket.assigns.state, state_params) do
      {:ok, state} ->
        notify_parent({:saved, state})

        {:noreply,
         socket
         |> put_flash(:info, "State updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_state(socket, :new, state_params) do
    case Territory.create_state(state_params) do
      {:ok, state} ->
        notify_parent({:saved, state})

        {:noreply,
         socket
         |> put_flash(:info, "State created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
