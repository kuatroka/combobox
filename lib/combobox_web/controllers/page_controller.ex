defmodule ComboboxWeb.PageController do
  use ComboboxWeb, :controller

  def home(conn, _params) do
    # Render the home page template
    render(conn, :home)
  end
end
