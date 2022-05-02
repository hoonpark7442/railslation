function setCurrentUserToNavBar(user) {
  const userNavLink = document.getElementById('first-nav-link');
  userNavLink.href = `/${user.name}`;
  userNavLink.getElementsByTagName('span')[0].textContent = user.name;
  userNavLink.getElementsByTagName(
    'small',
  )[0].textContent = `@${user.username}`;

  if (user.admin) {
    document
      .getElementsByClassName('js-header-menu-admin-link')[0]
      .classList.remove('hidden');
  }
}

function initializeBaseUserData() {
  const user = userData();
  setCurrentUserToNavBar(user);
}