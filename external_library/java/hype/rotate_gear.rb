require 'picrate'

# The sketch class
class RotateGears < Processing::App
  load_libraries :color_group, :hype
  %w[H HShape].freeze.each do |klass|
    java_import "hype.#{klass}"
  end
  java_import 'hype.extended.behavior.HRotate'
  attr_reader :box_x, :box_y, :box_z, :colors
  PALETTE = %w(#242424 #FF3300 #FF6600).freeze

  def settings
    size(640, 640)
  end

  def setup
    sketch_title 'HRotate Gears'
    H.init(self)
    color_group = ColorGroup.from_web_array(PALETTE.to_java(:string))
    @colors = color_group.colors
    H.background(colors[0])
    svg1 = HShape.new(data_path('cog_sm.svg'))
    svg2 = HShape.new(data_path('cog_lg.svg'))
    H.add(svg1).enableStyle(false).fill(colors[1]).anchorAt(H::CENTER).loc(223, 413)
    HRotate.new(svg1, -0.5)
    H.add(svg2).enableStyle(false).fill(colors[2]).anchorAt(H::CENTER).loc(690, 260)
    HRotate.new(svg2, 0.3333)
  end

  def draw
    H.draw_stage
  end
end

RotateGears.new
