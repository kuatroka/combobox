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

  def nav_link(assigns) do
    ~H"""
    <a
      href={@href}
      class={[
        "block py-2 pl-3 pr-4 rounded lg:p-0",
        if(@active,
          do: "text-white bg-blue-700 lg:bg-transparent lg:text-blue-700 dark:text-white",
          else: "text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-blue-700 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700"
        )
      ]}
    >
      <%= render_slot(@inner_block) %>
    </a>
    """
  end



  embed_templates "layouts/*"
end
