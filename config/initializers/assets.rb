Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join("node_modules")

Rails.application.config.assets.precompile += %w(*.jpg *.png)
Rails.application.config.assets.precompile += %w(admin.js admin.scss)
Rails.application.config.assets.precompile += %w(home.js home.scss)
Rails.application.config.assets.precompile += %w(users.js users.scss)
