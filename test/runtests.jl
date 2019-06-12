using Geotherm
using Test

@testset "Geotherm.jl" begin
    @test include("TestGeometry.jl")
    @test include("TestIntegrate.jl")
end
