require 'config/requirements'
require 'config/hoe' # setup Hoe + all gem configuration
require 'spec'
require 'spec/rake/spectask'

Dir['tasks/**/*.rake'].each { |rake| load rake }

def ant(*args)
  system "ant -logger org.apache.tools.ant.NoBannerLogger #{args.join(' ')}"
end

task :build_fixtures do
  puts "Building fixtures..."
  ant "build_fixtures"
  system "jar cf build/jrsplenda-fixtures.jar -C build/classes ."
end

Spec::Rake::SpecTask.new :spec => [:build_fixtures] do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--color']
end

Spec::Rake::SpecTask.new :specdoc => [:build_fixtures] do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--format=specdoc --color']
end

namespace :sample do
  task :build_sample_fixtures do
    puts "Building fixtures..."
    ant "build_sample_fixtures"
    system "jar cf build/jrsplenda-sample-fixtures.jar -C build/sample/classes ."    
  end

  Spec::Rake::SpecTask.new :run => [:build_sample_fixtures] do |t|
    t.spec_files = FileList['sample/**/*_spec.rb']
    t.spec_opts = ['--color']
  end
end

