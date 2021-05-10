# frozen_string_literal: true

# Noise Generator
class Generator
  include SmoothNoise
  attr_reader :nx, :ny, :nz

  R = 6
  RR = 1

  def initialize(phi, theta)
    base = R + RR * Math.cos(phi)
    tx = base * Math.cos(theta)
    ty = base * Math.sin(theta)
    tz = RR * Math.sin(phi)
    @nx = MathTool.norm(tx, 0.0, R + RR)
    @ny = MathTool.norm(ty, 0.0, R + RR)
    @nz = MathTool.norm(tz, 0.0, RR)
  end

  def noisef(time)
    (
      (SmoothNoise.noise(nx, ny, nz, time) + 1) * 128
    ).floor
  end
end
