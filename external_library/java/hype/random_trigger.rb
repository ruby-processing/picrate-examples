require 'picrate'

# The sketch class
class RandomTrigger < Processing::App

  load_libraries :hype, :color_group

  %w[H HRect].freeze.each do |klass|
    java_import "hype.#{klass}"
  end

  java_import 'hype.extended.behavior.HRandomTrigger'

  PALETTE = %w[#242424 #999999 #202020].freeze
  KEY = %i[background stroke fill].freeze

  def settings
    size(640,640)
  end

  def setup
    sketch_title 'Random Trigger'
    group = ColorGroup.from_web_array(PALETTE.to_java(:string))
    col = KEY.zip(group.colors).to_h
    H.init(self)
    H.background(col[:background])
    # Create a new randTrigger with a 1 in 15 chance
    # of triggering everytime H.draw_stage is called.
    ran_trig = HRandomTrigger.new(1.0 / 15)
    # ranTrig = HRandomTrigger.new.chance( 1.0 / 15 ) # same as above

    d = H.add(
      HRect.new
      .rounding(8))
      .stroke_weight(2)
      .stroke(col[:stroke])
      .fill(col[:fill])
      .loc_at(H::CENTER)
      .size(50 + (rand(3) * 50))
      .anchor_at(H::CENTER
      )

      # Setting the callback is similar to HTimer, we replace an anonymous class
      # instance with a block in PiCrate

      ran_trig.callback do
        d.loc(
          rand(50..width - 50),
          rand(50..height - 50)).size( 50 + (rand(3) * 50))
          .anchor_at(H::CENTER)
          .rotation_rad(rand(TWO_PI)
        )
      end
    end

    def draw
      H.draw_stage
    end
  end

  RandomTrigger.new
