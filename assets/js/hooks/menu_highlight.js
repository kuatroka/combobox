const MenuHighlight = {
  mounted() {
    console.log("MenuHighlight hook mounted");
    
    // Set initial active state based on current URL
    this.highlightCurrentPath();

    // Listen for LiveView navigation events
    window.addEventListener("phx:page-loading-stop", () => {
      this.highlightCurrentPath();
    });

    // Handle resize events
    this.handleResize = () => {
      const menu = document.getElementById('mobile-menu-2');
      if (menu) {
        if (window.innerWidth >= 1024) { // lg breakpoint
          menu.classList.remove('hidden');
          menu.style.display = ''; // Remove inline style if any
        } else {
          menu.classList.add('hidden');
        }
      }
    };

    window.addEventListener('resize', this.handleResize);
    
    // Initial check
    this.handleResize();

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
    window.removeEventListener('resize', this.handleResize);
  }
};

export default MenuHighlight;
