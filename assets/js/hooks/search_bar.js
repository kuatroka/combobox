const SearchBar = {
  mounted() {
    this.searchInput = this.el.querySelector('#territory-search-input');
    
    // Handle keyboard navigation
    this.handleKeyDown = (e) => {
      if (["ArrowUp", "ArrowDown", "Enter", "Escape"].includes(e.key)) {
        e.preventDefault();
        this.pushEvent("handle_key", { key: e.key });
      }
    };

    window.addEventListener("keydown", this.handleKeyDown);

    // Handle visual updates when selected item changes
    this.handleEvent("update_selected", ({ id }) => {
      const element = document.getElementById(id);
      if (element) {
        // Scroll the element into view
        element.scrollIntoView({ behavior: "smooth", block: "nearest" });
        
        // Update aria-selected and visual state
        const allOptions = this.el.querySelectorAll('[role="option"]');
        allOptions.forEach(option => {
          option.setAttribute('aria-selected', 'false');
          option.classList.remove('bg-slate-100', 'text-sky-800');
          const link = option.querySelector('a');
          if (link) {
            link.tabIndex = -1;
          }
        });
        
        // Update selected item
        element.setAttribute('aria-selected', 'true');
        element.classList.add('bg-slate-100', 'text-sky-800');
        const selectedLink = element.querySelector('a');
        if (selectedLink) {
          selectedLink.tabIndex = 0;
          // Set focus to the selected link to show its URL in the status bar
          // selectedLink.focus();
          window = selectedLink.getAttribute('href');
        }
      }
    });
  },

  destroyed() {
    window.removeEventListener("keydown", this.handleKeyDown);
  }
}

export default SearchBar
