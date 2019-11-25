require 'picrate'

# hold down mouse to see unfiltered output
class Droste < Processing::App
  load_library :video
  java_import 'processing.video.Capture'
  attr_reader :cam, :my_filter, :origin

  def settings
    size(960, 720, P2D)
  end

  def setup
    sketch_title 'Droste'
    @origin = Time.now
    @my_filter = load_shader(data_path('droste.glsl'))
    my_filter.set('sketchSize', width.to_f, height.to_f)
    start_capture
  end

  def time
    (Time.now - origin) * 0.5
  end

  def start_capture
    @cam = Capture.new(self, 960, 720, 'UVC Camera (046d:0825)')
    cam.start
  end

  def draw
    return unless cam.available
    
    background 0
    cam.read
    set(0, 0, cam)
    my_filter.set('globalTime', time)
    return if mouse_pressed?
     
    filter(my_filter)
  end
end

Droste.new
