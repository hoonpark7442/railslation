const path = require('path');
const { environment } = require('@rails/webpacker')

environment.splitChunks((config) => {
  return {
    ...config,
    resolve: {
      ...config.resolve,
      alias: {
        ...(config.resolve ? config.resolve.alias : {}),
        '@crayons': path.resolve(__dirname, '../../app/javascript/crayons'),
        '@utilities': path.resolve(__dirname, '../../app/javascript/utilities'),
        '@images': path.resolve(__dirname, '../../app/assets/images'),
        '@admin-controllers': path.resolve(
          __dirname,
          '../../app/javascript/admin/controllers',
        ),
        '@components': path.resolve(
          __dirname,
          '../../app/javascript/shared/components',
        ),
        react: 'preact/compat',
        'react-dom': 'preact/compat',
      },
    },
  };
});

environment.loaders.delete('nodeModules');

module.exports = environment
