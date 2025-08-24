document.addEventListener('DOMContentLoaded', function() {
    const currentPath = window.location.pathname;

    const sidebarLinks = document.querySelectorAll('.sidebar-nav ul a');

    sidebarLinks.forEach(function(link) {
        const linkPath = new URL(link.href).pathname;

        if (currentPath === linkPath) {
            link.classList.add('active');
        }
    });
});