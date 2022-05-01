function generateUploadFormdata(payload) {
  const token = window.csrfToken;
  const formData = new FormData();
  formData.append('authenticity_token', token);
  // formData.append('image',payload.image )

  Object.entries(payload.image).forEach(([_, value]) =>
    formData.append('image', value),
  );

  return formData;
}

export function generateMainImage({ payload, successCb, failureCb, signal }) {
  fetch('/image_uploads', {
    method: 'POST',
    headers: {
      'X-CSRF-Token': window.csrfToken,
    },
    body: generateUploadFormdata(payload),
    credentials: 'same-origin',
    signal,
  })
    .then((response) => response.json())
    .then((json) => {
      if (json.error) {
        throw new Error(json.error);
      }
      const { links } = json;
      const { image } = payload;
      return successCb({ links, image });
    })
    .catch(failureCb);
}