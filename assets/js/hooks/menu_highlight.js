const MenuHighlight = {
  mounted() {
    console.log("MenuHighlight hook mounted");
    
    // Set initial active state based on current URL
    this.highlightCurrentPath();

    // Listen for LiveView navigation events
    window.addEventListener("phx:page-loading-stop", () => {
      this.highlightCurrentPath();
    });

    this.handleClick = (e) => {
      const clickedItem = e.target.closest('.menu-item');
      if (clickedItem) {
        this.highlightMenuItem(clickedItem);
      }
    };

    this.el.addEventListener('click', this.handleClick);
  },

  highlightMenuItem(item) {
    // Remove highlight from all items
    this.el.querySelectorAll('.menu-item').forEach(item => {
      item.classList.remove('text-blue-700', 'bg-blue-50');
      item.classList.add('text-gray-700');
    });

    // Add highlight to clicked item
    item.classList.remove('text-gray-700');
    item.classList.add('text-blue-700', 'bg-blue-50');
  },

  highlightCurrentPath() {
    const currentPath = window.location.pathname;
    const menuItems = this.el.querySelectorAll('.menu-item');
    
    menuItems.forEach(item => {
      if (item.getAttribute('href') === currentPath) {
        this.highlightMenuItem(item);
      }
    });
  },

  destroyed() {
    this.el.removeEventListener('click', this.handleClick);
  }
};

export default MenuHighlight;
