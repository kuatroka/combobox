defmodule ComboboxWeb.Router do
  use ComboboxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ComboboxWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ComboboxWeb do
    pipe_through :browser

    live_session :default, on_mount: ComboboxWeb.Live.Hooks.UrlTracker do
      live "/global-search", TerritoryListLive.Index, :global_search

      live "/", PageLive.Home, :index

      live "/countries", CountryLive.Index, :index
      live "/countries/new", CountryLive.Index, :new
      live "/countries/:country_code/edit", CountryLive.Index, :edit

      live "/countries/:country_code", CountryLive.Show, :show
      live "/countries/:country_code/show/edit", CountryLive.Show, :edit

      #######
      live "/cities", CityLive.Index, :index
      live "/cities/new", CityLive.Index, :new
      live "/cities/:id/edit", CityLive.Index, :edit
      live "/cities/:id", CityLive.Show, :show
      live "/cities/:id/show/edit", CityLive.Show, :edit

      live "/states", StateLive.Index, :index
      live "/states/new", StateLive.Index, :new
      live "/states/:code/edit", StateLive.Index, :edit
      live "/states/:code", StateLive.Show, :show
      live "/states/:code/show/edit", StateLive.Show, :edit

      live "/territories_list", TerritoryListLive.Index, :index
      live "/territories_list/new", TerritoryListLive.Index, :new
      live "/territories_list/:code/edit", TerritoryListLive.Index, :edit

      live "/territories_list/:code", TerritoryListLive.Show, :show
      live "/territories_list/:code/show/edit", TerritoryListLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ComboboxWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:combobox, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ComboboxWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
