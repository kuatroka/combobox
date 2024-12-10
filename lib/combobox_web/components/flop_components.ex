defmodule ComboboxWeb.FlopComponents do
  use Phoenix.Component
  import ComboboxWeb.CoreComponents

  #### flop phoenix components

  def table_opts do
    [
      table_attrs: [class: "w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400"],
      thead_attrs: [class: "text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"],
      thead_tr_attrs: [],
      thead_th_attrs: [scope: "col", class: "px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-400"],
      th_wrapper_attrs: [class: "flex items-center"],
      tbody_attrs: [class: "divide-y divide-gray-200 dark:divide-neutral-700"],
      tbody_tr_attrs: [class: " bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 cursor-pointer"],
      tbody_td_attrs: [class: " px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 dark:text-neutral-200"],
      symbol_asc: symbol_asc(),
      symbol_desc: symbol_desc(),
      symbol_unsorted: symbol_unsorted()
    ]
  end

  defp symbol_asc do
    assigns = %{}
    ~H"""
    <.icon name="hero-chevron-up" class="size-3" />
    """
  end

  defp symbol_desc do
    assigns = %{}
    ~H"""
    <.icon name="hero-chevron-down" class="size-3" />
    """
  end

  defp symbol_unsorted do
    assigns = %{}
    ~H"""
    <.icon name="hero-chevron-up-down" class="size-4" />
    """
  end

  #####  pagination options

  def pagination_opts do
    [
      page_links: :hide,
      # The attributes for the <nav> element that wraps the pagination links
      wrapper_attrs: [class: "inline-flex -space-x-px rtl:space-x-reverse text-sm h-8"],
      previous_link_attrs: [class: "flex items-center justify-center px-3 h-8 ms-0 leading-tight font-semibold text-gray-900 dark:text-white bg-white border border-gray-300 rounded-s-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"],
      previous_link_content:  Phoenix.HTML.raw("Previous"),
      # disabled_class: "cursor-not-allowed no-underline hover:no-underline pointer-events-none disabled",
      disabled_class: "cursor-not-allowed no-underline hover:no-underline text-opacity-50",
      next_link_attrs: [class: "flex items-center justify-center px-3 h-8 leading-tight font-semibold text-gray-900 bg-white border border-gray-300 rounded-e-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"],
      next_link_content: Phoenix.HTML.raw("Next")
    ]
  end




  attr :meta, Flop.Meta, required: true
  attr :path, :any, default: nil
  attr :on_paginate, JS, default: nil
  attr :target, :any, default: nil

  def pagination(%{meta: meta} = assigns) do
    assigns =
      assign(assigns,
        from: meta.current_offset + 1,
        to: min(meta.current_offset + meta.page_size, meta.total_count)
      )
    ~H"""
    <nav :if={@meta.total_pages > 1} class="flex items-center flex-column flex-wrap md:flex-row justify-between py-4 px-2" aria-label="Table navigation">
    <span class="text-sm font-normal text-gray-500 dark:text-gray-400 mb-4 md:mb-0 block w-full md:inline md:w-auto">Showing <span class="font-semibold text-gray-900 dark:text-white">{@from}-{@to}</span> of <span class="font-semibold text-gray-900 dark:text-white">{@meta.total_count}</span></span>
      <Flop.Phoenix.pagination
        opts={pagination_opts()}
        meta={@meta}
        path={@path}
        on_paginate={@on_paginate}
        target={@target}
      />
    </nav>
    """
  end

end
