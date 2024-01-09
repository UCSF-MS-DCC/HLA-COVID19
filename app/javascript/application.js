// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
Turbo.session.drive = false
import jquery from '../../node_modules/jquery'
window.jQuery = jquery
window.$ = jquery
//import * as bootstrap from "bootstrap"
import "datatables.net-bs5"
import './src/home'
import './src/datatables'
import './src/application_prev'
import './src/project'
import './src/cable'
import './controllers'
