defmodule Combobox.Repo do
  use Ecto.Repo,
    otp_app: :combobox,
    adapter: Ecto.Adapters.SQLite3
end
