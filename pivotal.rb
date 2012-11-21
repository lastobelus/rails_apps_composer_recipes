gem 'whereuat', git: "git://github.com/lastobelus/whereuat.git"

@prefs[:pivotal_project_name] = config[:pivotal_project_name]

after_bundler do
end

after_everything do
  template 
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
