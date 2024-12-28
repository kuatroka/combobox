defmodule ComboboxWeb.PageLive.Home do
  use ComboboxWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Home")}
  end

  @impl true
  def handle_params(_params, url, socket) do
    current_path = URI.parse(url).path
    {:noreply, socket |> assign(:current_path, current_path)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-1/3 bg-base-200 flex items-start justify-center pt-40">
      <div class="hero-content text-center">
        <div class="max-w-md">
          <h1 class="text-5xl font-bold">Welcome Home</h1>
          <p class="py-6">Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quod.</p>
        </div>
      </div>
    </div>
    """
  end
end
