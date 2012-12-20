after_bundler do
  say "running generators"
  say "prefs: #{prefs[:run_generators].inspect}"
  prefs[:run_generators].each do |provider|
    gem_name, generators  =  provider.first
    gem gem_name
    generators.each do |generator|  
      generate "active_admin:install #{config['activeadmin_admin_user_model']}#{registerable}"  
      git :add => '-A' if prefer :git, true
      git :commit => %Q{-qm "#{generator}"} if prefer :git, true
    end
  end
end


__END__

name: RunGenerators
description: >
  Run the specified generators. Provide generators as an array where each element 
  is a one-element map where the key is the name of a gem that provides a generator(s)
  and the value is the name of, or an array of names of, generators to run
author: lastobelus

category: other

config: 