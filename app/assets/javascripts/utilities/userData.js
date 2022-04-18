'use strict';

function userData() {
  // console.log(document.body.dataset)
  const { user = null } = document.body.dataset;

  return JSON.parse(user);
}