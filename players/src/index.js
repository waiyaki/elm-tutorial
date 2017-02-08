require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

require('./index.html');

const Elm = require('./Main.elm');
const mountNode = document.getElementById('main');

// .embed() can take a second optional argument like an object
// describing data required to start the program, e.g. access token.
const app = Elm.Main.embed(mountNode);
