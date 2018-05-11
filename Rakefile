# -*- encoding: utf-8 -*-

PRWD = File.expand_path(__dir__)

desc 'run demo'
task :default => [:all]

desc 'autorun all samples'
task :all do
  Rake::Task[:demo].execute
  Rake::Task[:vecmath].execute
  Rake::Task[:shaders].execute
  # Rake::Task[:slider].execute
end

desc 'run demo samples'
task :demo do
  sh "cd #{PRWD}/demo && rake"
end

desc 'shaders'
task :shaders do
  sh "cd #{PRWD}/processing_app/shaders && rake"
end
#
# desc 'PixelFlow'
# task :pixel_flow do
#   sh "cd #{PRWD}/external_library/java/pixel_flow && rake"
# end
#
desc 'vecmath'
task :vecmath do
  sh "cd #{PRWD}/library/vecmath/vec2d && rake"
  sh "cd #{PRWD}/library/vecmath/vec3d && rake"
  sh "cd #{PRWD}/library/vecmath/arcball && rake"
end
#
# desc 'hype'
# task :hype do
#   sh "cd #{PRWD}/external_library/java/hype && rake"
# end
#
# desc 'slider'
# task :slider do
#   sh "cd #{PRWD}/processing_app/library/slider && rake"
# end
#
desc 'geomerative'
task :geomerative do
  sh "cd #{PRWD}/gems/geomerative && rake"
end
#
# desc 'hemesh'
# task :hemesh do
#   sh "cd #{PRWD}/external_library/java/hemesh && rake"
# end
#
# desc 'pbox2d'
# task :pbox2d do
#   sh "cd #{PRWD}/external_library/gem/pbox2d && rake"
#   sh "cd #{PRWD}/external_library/gem/pbox2d/revolute_joint && jruby revolute_joint.rb"
#   sh "cd #{PRWD}/external_library/gem/pbox2d/test_contact && jruby test_contact.rb"
#   sh "cd #{PRWD}/external_library/gem/pbox2d/mouse_joint && jruby mouse_joint.rb"
#   sh "cd #{PRWD}/external_library/gem/pbox2d/distance_joint && jruby distance_joint.rb"
# end
#
desc 'wordcram'
task :wordcram do
  sh "cd #{PRWD}/gems/ruby_wordcram && rake"
end
