// Native <details> keeps navigation usable when JavaScript is unavailable.
const menu = document.querySelector('.section-menu');
if (menu) {
  menu.querySelectorAll('nav a').forEach((link) => {
    link.addEventListener('click', () => {
      menu.open = false;
      const target = document.querySelector(link.hash);
      if (target) {
        target.setAttribute('tabindex', '-1');
        target.focus({ preventScroll: true });
      }
    });
  });
  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && menu.open) {
      menu.open = false;
      menu.querySelector('summary').focus();
    }
  });
  document.addEventListener('click', (event) => {
    if (!menu.contains(event.target)) menu.open = false;
  });
}
