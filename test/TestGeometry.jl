#=
TestGeometry.jl:
- Julia version: 1.0
- Author: qz
- Date: Jun 5, 2019
=#
module TestGeometry

using Test

using Geotherm

@testset "Test whether a point is in the rectangle" begin
    @test in(Point2D(6, 4), Rectangle(1, 10, 5, 20)) == false
    @test in(Point2D(6, 15), Rectangle(1, 10, 5, 20)) == true
    @test in(Point2D(5, 5), Rectangle(1, 10, 5, 20)) == true
    @test in(Point2D(1, 15), Rectangle(1, 10, 5, 20)) == true
    @test in(Point2D(1, 5), Rectangle(1, 10, 5, 20)) == true
end

end
