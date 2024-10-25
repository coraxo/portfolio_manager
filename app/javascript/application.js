// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"
import { Application } from "@hotwired/stimulus"
import ThemeController from "./controllers/theme_controller"

const application = Application.start()
application.register("theme", ThemeController)
