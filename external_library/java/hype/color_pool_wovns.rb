require 'picrate'

# The sketch class
class ColorPoolWovns < Processing::App
  load_libraries :hype, :color_group

  %w[H HDrawablePool HRect].freeze.each do |klass|
    java_import "hype.#{klass}"
  end
  %w[layout.HGridLayout colorist.HColorPool].freeze.each do |klass|
    java_import "hype.extended.#{klass}"
  end

  PALETTE = %w[#B83D4E #B56A8C #4688B5 #A53643 #5869A0 #487A9C #95577E #302D32 #0C0000 #020100 #070707]

  def settings
    size(2400, 6372)
  end

  def setup
    sketch_title 'Color Pool Wovns'
    H.init(self)
    H.background(color('#242424'))
    group = web_to_color_array(PALETTE)
    colors = HColorPool.new(web_to_color_array(PALETTE))
    pool = HDrawablePool.new(15_876)
    pool.auto_add_to_stage
    .add(HRect.new(50))
    .layout(HGridLayout.new.start_x(0).start_y(0).spacing(50, 50).cols(126))
    .on_create do |obj|
      i = pool.current_index
      obj.no_stroke.fill(colors.get_color(i))
    end
    .request_all
    H.draw_stage
    save_frame(data_path('wovns.png'))
  end
end

ColorPoolWovns.new
