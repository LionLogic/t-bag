require_relative 'lib/tbag'

task :build do
  system 'gem build tbag.gemspec'
end

task :release => :build do
  system "gem push t-bag-#{T_BAG::VERSION}.gem"
end