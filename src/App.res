let mkServer = () => {
  open Server.AppBuilder
  builder()->getRoute("/api/hello", Server.hello)->getRoute("/api/hello/:name", Server.hello)->build
}

let run = () => {
  let server = mkServer()
  let port = Server.getPort()->Belt.Option.getWithDefault(8080)
  server->Express.listenWithCallback(port, _ =>
    Js.Console.log(`Listening on http://localhost:${port->Belt.Int.toString}`)
  )
}
