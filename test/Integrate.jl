using Geotherm.Geometry: Point2D
using Geotherm.Integrate: runge_kutta_iter, runge_kutta

@testset "Test `runge_kutta`" begin
    @test runge_kutta_iter(
        Point2D(1.0, 1.0),
        (x, y) -> x * 2 + y * 3,
    ) == Point2D(1.01, 1.05085856375)
    @test runge_kutta(
        Point2D(1.0, 1.0),
        (x, y) -> x * 2 + y * 3,
        0.01,
        4,
    ) == [
        Point2D(1.0, 1.0),
        Point2D(1.01, 1.05085856375),
        Point2D(1.02, 1.103469031571201),
        Point2D(1.03, 1.157884756885266),
    ]
end
