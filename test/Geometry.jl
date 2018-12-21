#=
Integrate:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-08
=#

using Test

using Geotherm

@test in(Point2D(6, 4), Rectangle(1, 10, 5, 20)) == false

@test in(Point2D(6, 15), Rectangle(1, 10, 5, 20)) == true

@test in(Point2D(5, 5), Rectangle(1, 10, 5, 20)) == true

@test in(Point2D(1, 15), Rectangle(1, 10, 5, 20)) == true

@test in(Point2D(1, 5), Rectangle(1, 10, 5, 20)) == true
