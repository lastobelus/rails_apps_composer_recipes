if recipes.include? 'mongoid'
  gem 'formtastic', "~> 2.1.1"
  gem 'activeadmin-mongoid'
else
  gem 'activeadmin'
end
gem "meta_search",    '>= 1.1.0.pre'

gem 'foundation-activeadmin', git: "git://github.com/lastobelus/foundation-activeadmin.git"

# sass-rails is also required but is by default in rails



after_bundler do
  if prefer(:activeadmin_users, true)
    generate 'active_admin:install User' 
    generate 'active_admin:resource User' 
  else
    generate 'active_admin:install --skip-users'
  end
end

<<-eos
# https://github.com/ryanb/cancan/wiki/changing-defaults
def current_ability
  @current_ability ||= Ability.new(current_admin_user)
end
eos


<<-eos
# need to switch between root path and admin root path depending on user type
rescue_from CanCan::AccessDenied do |exception|
  respond_to do |format|
    format.html do
      redirect_to admin_root_path, :alert => exception.message
    end
  end
end
eos

__END__

name: ActiveAdmin
description: "Install Active Admin and add a dashboard for Users"
author: systho

category: other

config:
  - user_model:
      type: string
      prompt: "What model will you use for admin users ? type 'skip' to skip this step (default is AdminUser)"
