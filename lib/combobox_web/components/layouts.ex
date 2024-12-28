defmodule ComboboxWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use ComboboxWeb, :controller` and
  `use ComboboxWeb, :live_view`.
  """
  use ComboboxWeb, :html

  defp assign_uri(socket) do
    uri = socket.assigns[:uri] || "/"
    assign(socket, :uri, uri)
  end

  def render("app.html", assigns) do
    assigns = assign_uri(assigns)
    ~H"""
    <%= render("layouts/app.html", assigns) %>
    """
  end

  def render("root.html", assigns) do
    assigns = assign_uri(assigns)
    ~H"""
    <%= render("layouts/root.html", assigns) %>
    """
  end

  embed_templates "layouts/*"
end
