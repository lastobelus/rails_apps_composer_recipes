
before_config do
  # Code here is run before any configuration prompts.
end


after_bundler do
  # Code here is run after Bundler installs all the gems for the project.
  # Use this section to run generators and rake tasks.
  # Download any files from a repository for models, controllers, views, and routes.
end

after_everything do
  # This block is run after the 'after_bundler' block.
  # Use this section to finalize the application.
  # Run database migrations or make a final git commit.
  say_wizard "recipe running after everything"
end

gem "config_spartan"
create_file "config/initializers/app_config.rb" do
  <<-'eos'
AppConfig = ConfigSpartan.create do
  ['app_config', "app_config_#{Rails.env}", 'app_config_local'].each do |f|
    f << ".yaml"
    f = Rails.root.join('config', f)
    file f if File.exist?(f)
  end
end
  eos
end

create_file 'config/app_config.yaml'
%w{test development production}.each do |env|
  create_file "config/app_config_#{env}.yaml" do
    <<-eos
# AppConfig settings for #{env}
dbg:
  env: #{env}
eos
  end
end
create_file "config/app_config_local.yaml.sample" do
  <<-eos
# This file should be in .gitignore and is for local or temporary overrides to the app_config.
    
  eos
end
git :add => '-A' if prefer :git, true
git :commit => "-qm 'rails_apps_composer: lastobelus:config'" if prefer :git, true
append_file ".gitignore", "config/app_config_local.yaml"

# A recipe has two parts: the Ruby code and YAML matter that comes after a blank line with the __END__ keyword.

__END__

name: zurb
description: "Adds Zurb starting site templates to app, with a chooser"
author: lastobelus

requires: [setup, gems, frontend]
run_after: [setup, gems, frontend]
category: configuration

