using Geotherm
using Test

@testset "Geotherm.jl" begin
    @test include("Geometry.jl")
    @test include("Integrate.jl")
end
