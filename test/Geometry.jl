#=
Integrate:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-08
=#

using Test

using Geotherm

@test within_rectangle(Rectangle(1, 10, 20, 40), Point(9, 60)) == false
