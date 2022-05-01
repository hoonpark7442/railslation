import { h } from 'preact';
import PropTypes from 'prop-types';
import { ImageUploader } from './ImageUploader';

export const Toolbar = ({ version }) => {
  return (
    <div
      className="crayons-article-form__toolbar border-t-0"
    >
      <ImageUploader editorVersion={version} />
    </div>
  );
};

Toolbar.propTypes = {
  version: PropTypes.string.isRequired,
};

Toolbar.displayName = 'Toolbar';
