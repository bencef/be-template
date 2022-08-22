const path = require('path');

const serverConfig = {
  target: 'node',
  mode: 'production',
  entry: './index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'index.js',
  },
};

module.exports = [ serverConfig ];
