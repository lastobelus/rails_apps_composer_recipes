if recipes.include? 'mongoid'
  gem 'formtastic', "~> 2.1.1"
  gem 'activeadmin-mongoid'
else
  gem 'activeadmin'
end
gem "meta_search",    '>= 1.1.0.pre'

gem 'foundation-activeadmin', git: "git://github.com/lastobelus/foundation-activeadmin.git"

# sass-rails is also required but is by default in rails

@prefs[:activeadmin_admin_user_model] = config[:activeadmin_admin_user_model]

registerable = config[:activeadmin_user_registerable] ? ' --registerable' : ''
after_bundler do
  say "after_bundler. config: #{config.inspect}"
  if config["activeadmin_generate_devise_admin_user"]
    generate "active_admin:install #{config['activeadmin_admin_user_model']}#{registerable}"
  else
    generate 'active_admin:install --skip-users'
  end
  
  config['activeadmin_admin_user_model'] = "AdminUser" if config['activeadmin_admin_user_model'].empty?
  
  if config["activeadmin_users_panel"]
    generate "active_admin:resource #{config['activeadmin_admin_user_model']}"
    generate "active_admin:resource User" unless (config['activeadmin_admin_user_model'] == "User")
  end
  
  run 'bundle exec rake db:migrate'

end

inject_into_file 'app/controllers/application_controller.rb', :before => "\nend", :verbose => true do <<-RUBY
\n
  # https://github.com/ryanb/cancan/wiki/changing-defaults
  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end
  
  # need to switch between root path and admin root path depending on user type
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        redirect_to admin_root_path, :alert => exception.message
      end
    end
  end
  
RUBY
end 


__END__

name: ActiveAdmin
description: "Install Active Admin and add a dashboard for Users"
author: lastobelus

category: other

config:
  - activeadmin_users_panel:
      type: boolean
      prompt: Do you want to add a Users admin panel?
  - activeadmin_admin_user_model:
      type: string
      prompt: What should the Admin User model be called? (default AdminUser)
  - activeadmin_generate_devise_admin_user:
      type: boolean
      prompt: Do you want to generate a devise user for the admin user?
      if: activeadmin_admin_user_model
  - activeadmin_admin_user_registerable:
      type: boolean
      prompt: Do you want the admin user to be registerable?
      if: activeadmin_generate_devise_admin_user
