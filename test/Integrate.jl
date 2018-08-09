#=
Integrate:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-08
=#

using Test

using GeoTherm

@test runge_kutta_iter(Point(1.0, 1.0), (x, y) -> x * 2 + y * 3) == Point{Float64}(1.01, 1.05085856375)

# @show runge_kutta(Point(1.0, 1.0), (x, y) -> x * 2 + y * 3; nstep=4)
@test runge_kutta(Point(1.0, 1.0), (x, y) -> x * 2 + y * 3; nstep=4) == Point{Float64}[Point{Float64}(1.0, 1.0), Point{Float64}(1.01, 1.05086), Point{Float64}(1.02, 1.10347), Point{Float64}(1.03, 1.15788)]