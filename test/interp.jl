#=
bilinear:
- Julia version: 0.7
- Author: qz
- Date: 2018-08-08
=#

using Test

using GeoTherm

@test bilinear_interpolate(Rectangle(1.0, 2.0, 3.0, 4.0))(1.5, 3.5) == 3.5