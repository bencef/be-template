@module external helmet: unit => Express.middleware = "helmet"

open Express

module type AppBuilderS = {
  type t
  let builder: unit => t
  let getRoute: (t, string, (Express.req, Express.res) => unit) => t
  let build: t => Express.express
}

module AppBuilder: AppBuilderS = {
  type t = Express.express

  let getRoute = (app, route, callback) => {
    app->get(route, (req, res) => callback(req, res))
    app
  }

  let builder = () => {
    let app = expressCjs()
    app->use(helmet())
    app->use(jsonMiddleware())
    app
  }

  let build = x => x
}

let hello = (req, res) => {
  let name = req->params->Js.Dict.get("name")->Belt.Option.getWithDefault("world")
  let message = `Hello ${name}!`
  res->status(200)->json({"message": message})->ignore
}

let getPort: unit => option<int> = () => {
  let port = %raw(`process.env['PORT']`)
  port->Belt.Int.fromString
}
