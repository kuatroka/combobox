defmodule ComboboxWeb.FlopComponents do
  use Phoenix.Component

  #### flop phoenix components

  def table_opts do
    [
      table_attrs: [class: "min-w-full divide-y divide-gray-200 dark:divide-neutral-700"],
      thead_attrs: [class: "text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"],
      thead_tr_attrs: [],
      thead_th_attrs: [scope: "col", class: "px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-400"],
      th_wrapper_attrs: [class: "flex items-center"],
      tbody_attrs: [class: "divide-y divide-gray-200 dark:divide-neutral-700"],
      tbody_tr_attrs: [class: " bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 cursor-pointer"],
      tbody_td_attrs: [class: " px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 dark:text-neutral-200"],

      symbol_unsorted: Phoenix.HTML.raw(~s{<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-4">
  <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 15 12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" />
</svg>

      }),
      symbol_desc: Phoenix.HTML.raw(~s{<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-3">
  <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
</svg>
}),
      symbol_asc: Phoenix.HTML.raw(~s{<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-3">
  <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
</svg>
}),


    ]




  end

  def pagination_opts do
    [
      page_links: :hide,
      wrapper_attrs: [
      class: "text-center mt-4"
    ],
      previous_link_content: Phoenix.HTML.raw("← Previous"),
      previous_link_attrs: [
      class: "p-2 mr-2 border rounded border-slate-500"
    ],
      next_link_content: Phoenix.HTML.raw("Next →"),
      next_link_attrs: [
      class: "p-2 ml-2 border rounded border-slate-500"
      ]
    ]
  end


  # def pagination_opts do
  #   [
  #     # ellipsis_attrs: [class: "ellipsis"],
  #     # ellipsis_content: "‥",
  #     # next_link_attrs: [class: "next"],
  #     # next_link_content: next_icon(),
  #     # page_links: {:ellipsis, 3},
  #     page_links: :hide,
  #     # pagination_link_aria_label: &"#{&1}ページ目へ",
  #     # previous_link_attrs: [class: "prev"],
  #     # previous_link_content: previous_icon()
  #   ]
  # end

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
