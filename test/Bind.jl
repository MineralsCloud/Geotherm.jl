#=
Bind:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-09
=#

using Test

using Suppressor

using GeoTherm: bind, Point, Rectangle, pre

@show methods(bind)

@show bind(Point(50.0, 50.0), Rectangle(0.0, 0.0, 100.0, 200.0); n=100)

@show pre(Point(3.5, 3.6), rand(1.0:10.0, 10, 10))