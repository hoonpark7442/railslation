function toggleHamburgerNav() {
  hamburgerTrigger = document.querySelector('.js-hamburger-trigger')

  hamburgerTrigger.onclick = toggleBurgerMenu;
}

function toggleBurgerMenu() {
  const { leftNavState = 'closed' } = document.body.dataset;
  document.body.dataset.leftNavState =
    leftNavState === 'open' ? 'closed' : 'open';
}


toggleHamburgerNav();