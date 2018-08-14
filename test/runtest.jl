#!/usr/bin/env julia

using Test

using GeoTherm

tic()
println("Test 1")
@time @test include("Geometry.jl")
println("Test 2")
@time @test include("Interpolate.jl")
toc()

true