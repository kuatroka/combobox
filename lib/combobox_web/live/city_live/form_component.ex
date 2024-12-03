defmodule ComboboxWeb.CityLive.FormComponent do
  use ComboboxWeb, :live_component

  alias Combobox.Territory

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage city records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="city-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:city_id]} type="number" label="City" />
        <.input field={@form[:city_name]} type="text" label="City name" />
        <.input field={@form[:country_code]} type="text" label="Country code" />
        <.input field={@form[:state_code]} type="text" label="State code" />
        <.input field={@form[:latitude]} type="text" label="Latitude" />
        <.input field={@form[:longitude]} type="text" label="Longitude" />
        <:actions>
          <.button phx-disable-with="Saving...">Save City</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{city: city} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Territory.change_city(city))
     end)}
  end

  @impl true
  def handle_event("validate", %{"city" => city_params}, socket) do
    changeset = Territory.change_city(socket.assigns.city, city_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"city" => city_params}, socket) do
    save_city(socket, socket.assigns.action, city_params)
  end

  defp save_city(socket, :edit, city_params) do
    case Territory.update_city(socket.assigns.city, city_params) do
      {:ok, city} ->
        notify_parent({:saved, city})

        {:noreply,
         socket
         |> put_flash(:info, "City updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_city(socket, :new, city_params) do
    case Territory.create_city(city_params) do
      {:ok, city} ->
        notify_parent({:saved, city})

        {:noreply,
         socket
         |> put_flash(:info, "City created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
