gem 'whereuat', git: "git://github.com/lastobelus/whereuat.git"

@prefs[:pivotal_project_name] = config[:pivotal_project_name]

after_bundler do
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

name: Pivotal
description: "creates a Pivotal Tracker project and adds whereuat integration for it"
author: lastobelus

category: other

config:
  - pivotal_tracker_token:
      type: string
      prompt: What is your Pivotal Tracker token?
  - pivotal_create_new:
      type: boolean
      prompt: Do you want to create a new Pivotal Tracker Project
  - pivotal_project_name:
      type: string
      prompt: What do you want to call the Pivotal Project?
      if: pivotal_create_new
  - pivotal_tracker_project_id:
      type: string
      prompt: What is the Pivotal Tracker project id?
      unless: pivotal_create_new
