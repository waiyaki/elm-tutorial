const data = require('./db.json')
const jsonServer = require('json-server')

const router = jsonServer.router('db.json');
let { id: initialId } = data.players.sort((a, b) => a > b).slice(-1)[0];
const server = jsonServer.create();

server.use(jsonServer.defaults());
server.use(jsonServer.bodyParser);
server.use((req, res, next) => {
  if (req.method === 'POST') {
    req.body.id = (++initialId).toString();
  }
  next();
});
server.use(router);

console.log('server listening at http://localhost:4000');
server.listen(4000);
