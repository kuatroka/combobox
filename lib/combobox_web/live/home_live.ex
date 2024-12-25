defmodule ComboboxWeb.HomeLive do
  use ComboboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.flash_group flash={@flash} />
    </div>
    """
  end
end
