#=
Bind:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-09
=#

using Test

using Geotherm: bind, Point, Rectangle

@show bind(rand(1.0:100.0, 100, 100), collect(0.0:0.1:1000.0), collect(0.0:0.1:1000.0), Point(1.05, 1.02), 0.01, 10)