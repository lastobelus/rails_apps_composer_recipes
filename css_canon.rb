gem 'css_canon'

after_bundler do
  say "setting up 'canonical' css structure"
  generate "active_admin:install #{config['activeadmin_admin_user_model']}#{registerable}"  

  git :add => '-A' if prefer :git, true
  git :commit => '-qm "devcloudcoder: css_canon"' if prefer :git, true
end


__END__

name: CssCanon
description: "Set up a 'canonical' css structure"
author: lastobelus

category: frontend

config: 