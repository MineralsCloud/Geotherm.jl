#=
LoadData:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-08
=#

using Test

using GeoTherm

datafiles = Dict(
    "α" => "alpha_tp.csv",
    "cp" => "cp_tp_jmolk.csv",
    "v" => "v_tp_ang3.csv"
)

println(load_csv(datafiles))