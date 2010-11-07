if Rails.env.development?
  require 'compass'
  require 'fancy-buttons'
  # If you have any compass plugins, require them here.

  Compass.add_project_configuration(Rails.root.join("config", "compass.config").to_s)
  Compass.configuration.environment = Rails.env.to_sym
  Compass.configure_sass_plugin!
end
