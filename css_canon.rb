gem 'css_canon'

after_bundler do
  say "setting up 'canonical' css structure"
  generate "active_admin:install #{config['activeadmin_admin_user_model']}#{registerable}"  
end


__END__

name: CssCanon
description: "Set up a 'canonical' css structure"
author: lastobelus

category: other

config:
 