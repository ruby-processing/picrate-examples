# -*- encoding: utf-8 -*-

PRWD = File.expand_path(__dir__)

desc 'run demo'
task :default => [:all]

desc 'autorun all samples'
task :all do
  Rake::Task[:demo].execute
  Rake::Task[:vecmath].execute
  Rake::Task[:shaders].execute
  Rake::Task[:sound].execute
end

desc 'run demo samples'
task :demo do
  sh "cd #{PRWD}/demo && rake"
end

desc 'shaders'
task :shaders do
  sh "cd #{PRWD}/shaders && rake"
end

desc 'vecmath'
task :vecmath do
  sh "cd #{PRWD}/library/vecmath/vec2d && rake"
  sh "cd #{PRWD}/library/vecmath/vec3d && rake"
  sh "cd #{PRWD}/library/vecmath/arcball && rake"
end

desc 'geomerative'
task :geomerative do
  sh "cd #{PRWD}/gems/geomerative && rake"
end

desc 'wordcram'
task :wordcram do
  sh "cd #{PRWD}/gems/ruby_wordcram && rake"
end

desc 'sound'
task :sound do
  sh "cd #{PRWD}/library/sound && rake"
end
