// Entry point for the build script in your package.json
import { Turbo } from "../../node_modules/@hotwired/turbo-rails"
Turbo.session.drive = false
import jquery from "../../node_modules/jquery"
window.jQuery = jquery
import "./src/home"
import "./src/datatables"
import "./src/application_prev"
import "./src/project"
import "./src/cable"
//import * as bootstrap from "bootstrap"
//import DataTable from "datatables.net-bs5"
import "./controllers"
