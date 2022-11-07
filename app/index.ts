const http = require("http");
const Sentry = require("@sentry/node");
require("@sentry/tracing");

Sentry.init({
  debug: true,
});

export function hello() {
  console.log("hello");
}

hello();

const HOST = "localhost";
const PORT = 4000;

const server = http.createServer((_req: any, res: any) => {
  res.writeHead(200);
  res.end("Hello World!");
});

server.listen(PORT, HOST, () => {
  console.log(`Server is running on http://${HOST}:${PORT}`);
});
