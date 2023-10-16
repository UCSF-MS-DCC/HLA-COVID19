// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import jquery from "jquery"
window.jQuery = jquery
import "./src/home"
import "./src/datatables"
import "./src/application_prev"
import "./src/project"
import "./src/cable"
import * as bootstrap from "bootstrap"
import DataTable from "datatables.net-bs5"
