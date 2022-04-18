/* global checkUserLoggedIn */

function fetchBaseData() {
  var xmlhttp;
  if (window.XMLHttpRequest) {
    xmlhttp = new XMLHttpRequest();
  } else {
    xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
  }
  xmlhttp.onreadystatechange = () => {
    if (xmlhttp.readyState === XMLHttpRequest.DONE) {
      
      var json = JSON.parse(xmlhttp.responseText);
      
      document.body.dataset.loaded = 'true';

      // Assigning User
      if (checkUserLoggedIn()) {
        document.body.dataset.user = json.user;
        browserStoreCache('set', json.user);
      } else {
        // Ensure user data is not exposed if no one is logged in
        delete document.body.dataset.user;
        browserStoreCache('remove');
      }
    }
  };

  xmlhttp.open('GET', '/async_info/base_data', true);
  xmlhttp.send();
}

function initializeBodyData() {
  fetchBaseData();
}
