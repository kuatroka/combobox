defmodule ComboboxWeb.FlopComponents do
  use Phoenix.Component

  #### flop phoenix components
  def pagination_opts do
    [
      # ellipsis_attrs: [class: "ellipsis"],
      # ellipsis_content: "‥",
      # next_link_attrs: [class: "next"],
      # next_link_content: next_icon(),
      # page_links: {:ellipsis, 3},
      page_links: :hide,
      # pagination_link_aria_label: &"#{&1}ページ目へ",
      # previous_link_attrs: [class: "prev"],
      # previous_link_content: previous_icon()
    ]
  end

  defp next_icon do
    assigns = %{}

    ~H"""
    <i class="fas fa-chevron-right"/>
    """
  end

  defp previous_icon do
    assigns = %{}

    ~H"""
    <i class="fas fa-chevron-left"/>
    """
  end

end
