import { Fragment, h } from 'preact';
import { useReducer, useEffect, useState } from 'preact/hooks';
import { generateMainImage } from '../actions';
import { Spinner } from '../../crayons/Spinner/Spinner';

const ImageIcon = () => (
  <svg
    width="24"
    height="24"
    viewBox="0 0 24 24"
    className="crayons-icon"
    xmlns="http://www.w3.org/2000/svg"
    role="img"
    aria-hidden="true"
  >
    <title id="a17qec5pfhrwzk9w4kg0tp62v27qqu9t">Upload image</title>
    <path d="M20 5H4v14l9.292-9.294a1 1 0 011.414 0L20 15.01V5zM2 3.993A1 1 0 012.992 3h18.016c.548 0 .992.445.992.993v16.014a1 1 0 01-.992.993H2.992A.993.993 0 012 20.007V3.993zM8 11a2 2 0 110-4 2 2 0 010 4z" />
  </svg>
);

ImageIcon.displayName = 'ImageIcon';

function imageUploaderReducer(state, action) {
  const { type, payload } = action;

  switch (type) {
    case 'uploading_image':
      return {
        ...state,
        uploadErrorMessage: null,
        uploadingImage: true,
        insertionImageUrls: [],
      };

    case 'upload_error':
      return {
        ...state,
        insertionImageUrls: [],
        uploadErrorMessage: payload.errorMessage,
        uploadingImage: false,
      };

    case 'upload_image_success':
      return {
        ...state,
        insertionImageUrls: payload.insertionImageUrls,
        uploadingImage: false,
        uploadErrorMessage: null,
      };

    default:
      return state;
  }
}

function linksToMarkdownForm(imageLink) {
	return `![Image description](${imageLink})`
}

const V1EditorImageUpload = ({
  uploadingImage,
  handleInsertionImageUpload,
  insertionImageUrls,
  uploadErrorMessage,
}) => {
  const [showCopiedImageText, setShowCopiedImageText] = useState(false);

  useEffect(() => {
    if (uploadingImage) {
      setShowCopiedImageText(false);
    }
  }, [uploadingImage]);

  return (
    <div className="flex items-center">
      {uploadingImage && (
        <span class="lh-base pl-3 border-0 py-2 inline-block">
          <Spinner /> Uploading...
        </span>
      )}

      {uploadingImage ? null : (
        <Fragment>
          <label className="cursor-pointer crayons-btn crayons-btn--ghost">
            <ImageIcon /> Upload image
            <input
              type="file"
              id="image-upload-field"
              onChange={handleInsertionImageUpload}
              className="screen-reader-only"
              accept="image/*"
              data-max-file-size-mb="25"
            />
          </label>
        </Fragment>
      )}

      {insertionImageUrls.length > 0 && (
        <input
		      data-testid="markdown-copy-link"
		      type="text"
		      className="crayons-textfield mr-2 w-50"
		      id="image-markdown-copy-link-input"
		      readOnly="true"
		      value={linksToMarkdownForm(insertionImageUrls)}
		    />
      )}

      {uploadErrorMessage ? (
        <span className="color-accent-danger">{uploadErrorMessage}</span>
      ) : null}
    </div>
  );
};


export const ImageUploader = ({
  editorVersion = 'v1',
}) => {
  const [state, dispatch] = useReducer(imageUploaderReducer, {
    insertionImageUrls: [],
    uploadErrorMessage: null,
    uploadingImage: false,
  });

  const { uploadingImage, uploadErrorMessage, insertionImageUrls } = state;

  function onUploadError(error) {
    dispatch({
      type: 'upload_error',
      payload: { errorMessage: error.message },
    });
  }

  function handleInsertionImageUpload(e, abortSignal) {
    const { files } = e.target;

    if (files.length > 0) {
      const payload = { image: files };
      dispatch({
        type: 'uploading_image',
      });

      generateMainImage({
        payload,
        successCb: handleInsertImageUploadSuccess,
        failureCb: onUploadError,
        signal: abortSignal,
      });
    }
  }

  function handleInsertImageUploadSuccess(response) {
  	console.log(response)
    dispatch({
      type: 'upload_image_success',
      payload: { insertionImageUrls: response.links },
    });

    document.getElementById('upload-success-info').innerText =
      'image upload complete';
  }

  // When the component is rendered in an environment that supports a native
  // image picker for image upload we want to add the aria-label attr and the
  // onClick event to the UI button. This event will kick off the native UX.
  // The props are unwrapped (using spread operator) in the button below
  //
  //
  //
  // This namespace is not implemented in the native side. This allows us to
  // deploy our refactor and wait until our iOS app is approved by AppStore
  // review. The old web implementation will be the fallback until then.
  // const useNativeUpload = Runtime.isNativeIOS('imageUpload_disabled');

  // Native Bridge messages come through ForemMobile events
  // document.addEventListener('ForemMobile', handleNativeMessage);

  return (
    <Fragment>
      <div
        id="upload-success-info"
        aria-live="polite"
        className="screen-reader-only"
      />
        <V1EditorImageUpload
          uploadingImage={uploadingImage}
          handleInsertionImageUpload={handleInsertionImageUpload}
          insertionImageUrls={insertionImageUrls}
          uploadErrorMessage={uploadErrorMessage}
        />
    </Fragment>
  );
};

ImageUploader.displayName = 'ImageUploader';