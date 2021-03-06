var http = require("http");
var spawn = require("child_process").spawn;
var createHandler = require("github-webhook-handler");

// 下面填写的myscrect跟github webhooks配置一样，下一步会说；path是我们访问的路径
var handler = createHandler({ path: "/webhook", secret: "matianqi" });

http
  .createServer(function (req, res) {
    handler(req, res, function (err) {
      res.statusCode = 404;
      res.end("no such location");
    });
  })
  .listen(4000);

handler.on("error", function (err) {
  console.error("Error:", err.message);
});

// 监听到push事件的时候执行我们的自动化脚本
handler.on("push", function (event) {
  console.log(
    "Received a push event for %s to %s from %s",
    event.payload.repository.name,
    event.payload.ref,
    event.payload.repository.html_url
  );

  runCommand(
    "sh",
    [
      "./publish.sh",
      event.payload.repository.html_url,
      event.payload.repository.name,
    ],
    function (txt) {
      console.log(txt);
    }
  );
});

function runCommand(cmd, args, callback) {
  var child = spawn(cmd, args);
  var resp = ''
  child.stdout.on("data", function (buffer) {
    resp += buffer.toString();
  });
  child.stdout.on("end", function () {
    callback(resp);
  });
}
