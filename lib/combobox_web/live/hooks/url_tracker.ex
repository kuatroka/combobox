defmodule ComboboxWeb.Live.Hooks.UrlTracker do
  import Phoenix.LiveView
  import Phoenix.Component

  def on_mount(:default, _params, _session, socket) do
    socket = assign(socket, :current_path, "/")
    
    if connected?(socket) do
      {:cont, attach_hook(socket, :track_url, :handle_params, &track_url_change/3)}
    else
      {:cont, socket}
    end
  end

  defp track_url_change(_params, url, socket) do
    path = URI.parse(url).path
    {:cont, assign(socket, :current_path, path)}
  end
end
