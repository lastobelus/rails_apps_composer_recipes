after_bundler do
  say "running generators"
  say "prefs: #{prefs[:run_generators].inspect}"
  prefs[:run_generators].each do |generator| 
    say "running #{generator}"
    generate generator, "--force"
    git :add => '-A' if prefer :git, true
    git :commit => %Q{-qm "#{generator}"} if prefer :git, true
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

run_after: [git, frontend, gems]

config: 
