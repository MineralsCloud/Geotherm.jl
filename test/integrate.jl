#=
integrate:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-08
=#

using Test

using GeoTherm

@test runge_kutta(Point(1, 1), (x, y) -> x * 2 + y * 3) == Point{Float64}(1.01, 1.05085856375)