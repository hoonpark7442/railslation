import { h, render } from 'preact';
import { Toolbar } from '../article-form/components/Toolbar';
import { getUserDataAndCsrfToken } from '@utilities/getUserDataAndCsrfToken';

HTMLDocument.prototype.ready = new Promise((resolve) => {
  if (document.readyState !== 'loading') {
    return resolve();
  }
  document.addEventListener('DOMContentLoaded', () => resolve());
  return null;
});

function loadForm() {
  getUserDataAndCsrfToken().then(({ currentUser, csrfToken }) => {
    window.currentUser = currentUser;
    window.csrfToken = csrfToken;

    const articleFormBody = document.getElementById('article-form__body');
    // const { article } = root.dataset;

    render(
      <Toolbar version="v1" />,
      articleFormBody,
      articleFormBody.firstElementChild,
    );
  });
}

document.ready.then(() => {
  loadForm();
});
