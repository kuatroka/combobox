defmodule ComboboxWeb.TerritoryListLive.FormComponent do
  use ComboboxWeb, :live_component

  alias Combobox.Territory

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage territory_list records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="territory_list-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:code]} type="text" label="Code" />
        <.input field={@form[:category]} type="text" label="Category" />
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Territory list</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{territory_list: territory_list} = assigns, socket) do
    changeset = Territory.change_territory_list(territory_list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"territory_list" => territory_list_params}, socket) do
    changeset = Territory.change_territory_list(socket.assigns.territory_list, territory_list_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"territory_list" => territory_list_params}, socket) do
    save_territory_list(socket, socket.assigns.action, territory_list_params)
  end

  defp save_territory_list(socket, :edit, territory_list_params) do
    case Territory.update_territory_list(socket.assigns.territory_list, territory_list_params) do
      {:ok, territory_list} ->
        notify_parent({:saved, territory_list})

        {:noreply,
         socket
         |> put_flash(:info, "Territory list updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_territory_list(socket, :new, territory_list_params) do
    case Territory.create_territory_list(territory_list_params) do
      {:ok, territory_list} ->
        notify_parent({:saved, territory_list})

        {:noreply,
         socket
         |> put_flash(:info, "Territory list created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
