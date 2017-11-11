# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( post.css)
Rails.application.config.assets.precompile += %w( file.scss)
Rails.application.config.assets.precompile += %w( user.scss)
Rails.application.config.assets.precompile += %w( home.scss)
Rails.application.config.assets.precompile += %w( registrations.css )
# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
