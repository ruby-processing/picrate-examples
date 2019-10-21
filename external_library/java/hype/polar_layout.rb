require 'picrate'

# The sketch class
class PolarLayout < Processing::App

  load_libraries :hype, :color_group
  %w[H HDrawablePool HCanvas HBox].freeze.each do |klass|
    java_import "hype.#{klass}"
  end
  %w[layout.HPolarLayout behavior.HOscillator colorist.HColorPool].freeze.each do |klass|
    java_import "hype.extended.#{klass}"
  end

  PALETTE = %w[#FFFFFF #F7F7F7 #ECECEC #CCCCCC #999999 #666666 #4D4D4D #333333 #242424 #202020 #111111 #080808 #000000].freeze
  attr_reader :pool, :colors, :box_depth

  def settings
    size(640, 640, P3D)
  end

  def setup
    sketch_title 'Polar Layout'
    H.init(self)
    @colors = HColorPool.new(web_to_color_array(PALETTE))
    H.background(group.last)
    H.use3D(true)
    @ranSeedNum = 1
    @box_depth = 60
    layout = HPolarLayout.new(0.7, 0.1).offset(width / 2, height / 2)
    @pool = HDrawablePool.new(600)
    pool.auto_add_to_stage
    .add(HBox.new.depth(box_depth).width(box_depth).height(box_depth))
    .layout(layout)
    .on_create do |obj|
      i = pool.current_index
      HOscillator.new.target(obj).property(H::Z).range(-900, 100).speed(1).freq(1).current_step(i)
      HOscillator.new.target(obj).property(H::ROTATION).range(-360, 360).speed(0.05).freq(3).current_step(i)
      HOscillator.new.target(obj).property(H::ROTATIONX).range(-360, 360).speed(0.3).freq(1).current_step(i * 2)
      HOscillator.new.target(obj).property(H::ROTATIONY).range(-360, 360).speed(0.3).freq(1).current_step(i * 2)
      HOscillator.new.target(obj).property(H::ROTATIONZ).range(-360, 360).speed(0.5).freq(1).current_step(i * 2)
    end
    .request_all
  end

  def draw
    lights
    i = 0
    pool.each do |d|
      d.no_stroke.fill(colors.get_color(i * @ranSeedNum))
      i += 1
    end
    @ranSeedNum += 0.5
    @ranSeedNum = 1 if @ranSeedNum > 300
    H.draw_stage
  end
end

PolarLayout.new
