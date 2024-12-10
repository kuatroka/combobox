const SearchBar = {
  mounted() {
    // Initialize any necessary state
    this.el.addEventListener("keydown", (e) => {
      if (["ArrowUp", "ArrowDown", "Tab", "Enter"].includes(e.key)) {
        // Prevent default behavior for these keys
        e.preventDefault()
        
        // Push the event to the LiveView
        this.pushEvent("handle_key", { key: e.key })
      }
    })
  },

  destroyed() {
    // Clean up if needed
  }
}

export default SearchBar
