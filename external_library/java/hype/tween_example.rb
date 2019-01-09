require 'picrate'

# The sketch class
class TweenExample < Processing::App

  load_libraries :hype, :color_group
  %w[H HDrawablePool HCanvas HRect].freeze.each do |klass|
    java_import "hype.#{klass}"
  end
  %w[HRandomTrigger HTimer HTween].freeze.each do |klass|
    java_import "hype.extended.behavior.#{klass}"
  end
  java_import 'hype.extended.colorist.HColorPool'


PALETTE = %w[#FFFFFF #F7F7F7 #ECECEC #333333 #0095a8 #00616f #FF3300 #FF6600].freeze

def settings
  size(640, 640)
end

def setup
  sketch_title('Tween Example')
  H.init(self)
  H.background(color('#000000'))
  group = ColorGroup.from_web_array(PALETTE.to_java(:string))
  colors = HColorPool.new(group.colors)
  canvas = HCanvas.new
  H.add(canvas).autoClear(false).fade(1)
  tween_trigger = HRandomTrigger.new(1.0 / 6)
  tween_trigger.callback do
    r = canvas.add(HRect.new(25 + (rand(0..5) * 25)).rounding(10))
              .stroke_weight(1)
              .stroke(colors.getColor)
              .fill(color('#000000'), 25)
              .loc(rand(0..width), rand(0..height))
              .anchor_at(H::CENTER)
    tween1 = HTween.new
                         .target(r).property(H::SCALE)
                         .start(0).end(1).ease(0.03).spring(0.95)
    tween2 = HTween.new
                         .target(r).property(H::ROTATION)
                         .start(-90).end(90).ease(0.01).spring(0.7)
    tween3 = HTween.new
                         .target(r).property(H::ALPHA)
                         .start(0).end(255).ease(0.1).spring(0.95)
    r.scale(0).rotation(-90).alpha(0)
    timer = HTimer.new.interval(250).unregister
    tween3.callback { timer.register }
    timer.callback do
      timer.unregister
      tween1.start(1).end(2).ease(0.01).spring(0.99).register
      tween2.start(90).end(-90).ease(0.01).spring(0.7).register
      tween3.start(255).end(0).ease(0.01).spring(0.95).register.callback { canvas.remove(r) }
    end
  end
end

def draw
  H.draw_stage
end
end

TweenExample.new
