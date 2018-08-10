#=
Bind:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-09
=#

using Test

using GeoTherm: bind, Point, Rectangle

@show bind(Point(1.05, 1.02), collect(0.0:0.1:1000.0), collect(0.0:0.1:1000.0), 0.01, 100)