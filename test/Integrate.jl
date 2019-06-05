#=
Integrate:
- Julia version: 1.0.0
- Author: qz
- Date: 2018-08-08
=#

using Test

using Geotherm
using Geotherm.Integrate

@testset "Test `runge_kutta`" begin
    @test runge_kutta_iter(Point2D(1.0, 1.0), (x, y) -> x * 2 + y * 3) == Point2D(1.01, 1.05085856375)
    @show runge_kutta(Point2D(1.0, 1.0), (x, y) -> x * 2 + y * 3, 0.01, 4) == [Point2D(1.0, 1.0), Point2D(1.01, 1.05086), Point2D(1.02, 1.10347), Point2D(1.03, 1.15788)]
end
