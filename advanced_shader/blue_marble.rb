# frozen_string_literal: true

require 'picrate'
# Earth model with bump mapping, specular texture and dynamic cloud layer.
# Adapted from the THREE.js tutorial to processing by Andres Colubri,
# translated to picrate by Martin Prout:
# http://learningthreejs.com/blog/2013/09/16/how-to-make-the-earth-in-webgl/
class BlueMarble < Processing::App
  attr_reader :cloud_shader, :clouds, :earth, :earth_shader, :earth_rotation
  attr_reader :clouds_rotation, :target_angle

  SHADER_NAME = %i[earth_frag earth_vert cloud_frag cloud_vert].freeze
  IMAGE_NAME = %i[earth_tex cloud_tex alpha_tex bump_map spec_map].freeze

  def setup
    sketch_title 'Blue Marble'
    @earth_rotation = 0
    @clouds_rotation = 0
    glsl_files = shader_paths.to_java(:string)
    shaders = SHADER_NAME.zip(glsl_files).to_h
    images = init_images
    textures = IMAGE_NAME.zip(images).to_h
    @earth_shader = load_shader(shaders[:earth_frag], shaders[:earth_vert])
    earth_shader.set('texMap', textures[:earth_tex])
    earth_shader.set('bumpMap', textures[:bump_map])
    earth_shader.set('specularMap', textures[:spec_map])
    earth_shader.set('bumpScale', 0.05)
    @cloud_shader = load_shader(shaders[:cloud_frag], shaders[:cloud_vert])
    cloud_shader.set('texMap', textures[:cloud_tex])
    cloud_shader.set('alphaMap', textures[:alpha_tex])
    @earth = create_shape(SPHERE, 200)
    earth.set_stroke(false)
    earth.set_specular(color(125))
    earth.set_shininess(10)
    @clouds = create_shape(SPHERE, 201)
    clouds.set_stroke(false)
  end

  def draw
    background(0)
    translate(width / 2, height / 2)
    point_light(255, 255, 255, 300, 0, 500)
    target_angle = map1d(mouse_x, (0..width), (0..TWO_PI))
    @earth_rotation += 0.05 * (target_angle - earth_rotation)
    shader(earth_shader)
    push_matrix
    rotate_y(earth_rotation)
    shape(earth)
    pop_matrix
    shader(cloud_shader)
    push_matrix
    rotate_y(earth_rotation + clouds_rotation)
    shape(clouds)
    pop_matrix
    @clouds_rotation += 0.001
  end

  def init_images
    %w[earthmap1k earthcloudmap earthcloudmaptrans earthbump1k earthspec1k].map do |img|
      load_image(data_path(format('%<name>s.jpg', name: img)))
    end
  end

  def shader_paths
    %w[EarthFrag EarthVert CloudFrag CloudVert].map do |shader|
      data_path(format('%<name>s.glsl', name: shader))
    end
  end

  def settings
    size(600, 600, P3D)
  end
end

BlueMarble.new
