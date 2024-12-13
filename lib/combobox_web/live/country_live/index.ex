defmodule ComboboxWeb.CountryLive.Index do
  use ComboboxWeb, :live_view

  import ComboboxWeb.FlopComponents
  import ComboboxWeb.SearchModalComponent

  alias Phoenix.LiveView.JS
  alias Combobox.Territory
  alias Combobox.Territory.Country

  @impl true
  def mount(_params, _session, socket) do
    socket = socket
      |> assign(:search_results, [])
      |> assign(:selected_index, 0)
      |> stream(:countries, [])
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _, socket) do
    case Territory.list_countries2(params) do
      {:ok, {countries, meta}} ->
        socket = socket
          |> assign(:meta, meta)
          |> stream(:countries, countries, reset: true)

        {:noreply, apply_action(socket, socket.assigns.live_action, params)}

      {:error, _meta} ->
        {:noreply, push_navigate(socket, to: ~p"/countries")}
    end
  end

  defp apply_action(socket, :edit, %{"country_code" => country_code}) do
    socket
    |> assign(:page_title, "Edit Country")
    |> assign(:country, Territory.get_country!(country_code))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Country")
    |> assign(:country, %Country{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Countries")
    |> assign(:country, nil)
  end

  @impl true
  def handle_info({ComboboxWeb.CountryLive.FormComponent, {:saved, country}}, socket) do
    {:noreply, stream_insert(socket, :countries, country)}
  end

  @impl true
  def handle_event("delete", %{"country_code" => country_code}, socket) do
    country = Territory.get_country!(country_code)
    {:ok, _} = Territory.delete_country(country)

    {:noreply, stream_delete(socket, :countries, country)}
  end

  @impl true
  def handle_event("handle_key", %{"key" => key}, socket) do
    case key do
      "ArrowDown" ->
        new_index = min(
          socket.assigns.selected_index + 1,
          max(length(socket.assigns.search_results) - 1, 0)
        )
        {:noreply, assign(socket, :selected_index, new_index)}

      "ArrowUp" ->
        new_index = max(socket.assigns.selected_index - 1, 0)
        {:noreply, assign(socket, :selected_index, new_index)}

      "Tab" ->
        new_index =
          if length(socket.assigns.search_results) > 0 do
            rem(socket.assigns.selected_index + 1, length(socket.assigns.search_results))
          else
            0
          end
        {:noreply, assign(socket, :selected_index, new_index)}

      "Enter" ->
        if length(socket.assigns.search_results) > 0 do
          selected_country = Enum.at(socket.assigns.search_results, socket.assigns.selected_index)
          {:noreply, push_navigate(socket, to: ~p"/countries/#{selected_country.country_code}")}
        else
          {:noreply, socket}
        end

      _ ->
        {:noreply, socket}
    end
  end

  def handle_event("change", %{"search" => %{"query" => ""}}, socket) do
    {:noreply, socket |> assign(:search_results, []) |> assign(:selected_index, 0)}
  end

  def handle_event("change", %{"search" => %{"query" => query}}, socket) do
    countries = Territory.search_countries(query)
    {:noreply, socket |> assign(:search_results, countries) |> assign(:selected_index, 0)}
  end

  def show_search_modal(js \\ %JS{}) do
    js
    |> JS.show(
      to: "#searchbox_container",
      transition:
        {"transition ease-out duration-200", "opacity-0 scale-95", "opacity-100 scale-100"}
    )
    |> JS.show(
      to: "#searchbar-dialog",
      transition: {"transition ease-in duration-100", "opacity-0", "opacity-100"}
    )
    |> JS.focus(to: "#search-input")
  end

  def close_search_modal(js \\ %JS{}) do
    js
    |> JS.hide(
      to: "#searchbox_container",
      transition:
        {"transition ease-in duration-100", "opacity-100 scale-100", "opacity-0 scale-95"}
    )
    |> JS.hide(
      to: "#searchbar-dialog",
      transition: {"transition ease-in duration-100", "opacity-100", "opacity-0"}
    )
  end

  def handle_keyboard_navigation(js \\ %JS{}) do
    js
    |> JS.push("handle_key", key: "ArrowDown", window: true)
    |> JS.push("handle_key", key: "ArrowUp", window: true)
    |> JS.push("handle_key", key: "Tab", window: true)
    |> JS.push("handle_key", key: "Enter", window: true)
  end
end
