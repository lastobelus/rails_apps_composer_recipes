gem "rails_apps_composer",  git: "git://github.com/lastobelus/rails_apps_composer.git", branch: "devcloudcoder"
gem "grit", group: "development"
# TODO: this is a nasty lurking dependency and all all these recipes need to be factored back in to devcloudcoder, removing their rails_apps_composer nature and making them regular rails generators OR thor tasks
gem ::Devcloudcoder.config.devcloudcoder_gem_spec_for_gemfile

__END__

name: devcloudcoder_core
description: "Core setup for a devcloudcoder app"
author: lastobelus

requires: []
run_after: []
category: devcloudcoder

