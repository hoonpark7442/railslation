function initializeLocalStorageRender() {
  try {
    var userData = browserStoreCache('get');
    if (userData) {
      document.body.dataset.user = userData;
      initializeBaseUserData();
    }
  } catch (err) {
    browserStoreCache('remove');
  }
}
