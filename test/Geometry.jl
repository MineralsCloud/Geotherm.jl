using Test

using Geotherm.Geometry

@testset "Test whether a point is in the rectangle" begin
    @test in(Point2D(6, 4), Rectangle(1, 10, 5, 20)) == false
    @test in(Point2D(6, 15), Rectangle(1, 10, 5, 20)) == true
    @test in(Point2D(5, 5), Rectangle(1, 10, 5, 20)) == true
    @test in(Point2D(1, 15), Rectangle(1, 10, 5, 20)) == true
    @test in(Point2D(1, 5), Rectangle(1, 10, 5, 20)) == true
end
