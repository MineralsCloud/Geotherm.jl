using Geotherm
using Test

@testset "Geotherm.jl" begin
    include("Geometry.jl")
    include("Integrate.jl")
end
