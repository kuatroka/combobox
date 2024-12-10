export const SearchBar = {
  mounted() {
    const searchBarContainer = (this as any).el as HTMLDivElement
    document.addEventListener('keydown', (event) => {
      if (event.key !== 'ArrowUp' && event.key !== 'ArrowDown') {
        return
      }

      const focusElement = document.querySelector(':focus') as HTMLElement

      if (!focusElement) {
        return
      }

      if (!searchBarContainer.contains(focusElement)) {
        return
      }

      event.preventDefault()

      const tabElements = document.querySelectorAll(
        '#search-input, #searchbox__results_list a'
      ) as NodeListOf<HTMLElement>
      const focusIndex = Array.from(tabElements).indexOf(focusElement)
      const tabElementsCount = tabElements.length - 1

      if (event.key === 'ArrowUp') {
        tabElements[focusIndex > 0 ? focusIndex - 1 : tabElementsCount].focus()
      }

      if (event.key === 'ArrowDown') {
        tabElements[focusIndex < tabElementsCount ? focusIndex + 1 : 0].focus()
      }
    })
  },
}
