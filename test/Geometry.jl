#=
Integrate:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-08
=#

using Test

using Geotherm

@test within_rectangle(Rectangle(1, 10, 5, 20), Point(6, 4)) == false

@test within_rectangle(Rectangle(1, 10, 5, 20), Point(6, 15)) == true

@test within_rectangle(Rectangle(1, 10, 5, 20), Point(5, 5)) == true

@test within_rectangle(Rectangle(1, 10, 5, 20), Point(1, 15)) == true

@test within_rectangle(Rectangle(1, 10, 5, 20), Point(1, 5)) == true
