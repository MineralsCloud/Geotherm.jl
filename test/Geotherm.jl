using CSV
using Downloads: download
using DataFrames: DataFrame
using DimensionalData: DimArray
using Geotherm: Temp, Press, generate_trace
using Geotherm.Geometry: Point2D

@testset "Test `generate_trace`" begin
    file = download(
        "https://raw.githubusercontent.com/MineralsCloud/geothermpy/master/tests/data/example.csv",
    )
    df = CSV.File(file) |> DataFrame
    ts = 1000:5:4000
    ps = [
        20,
        23,
        26,
        29,
        32,
        35,
        38,
        41,
        44,
        47,
        50,
        53,
        56,
        59,
        62,
        65,
        68,
        71,
        74,
        77,
        80,
        83,
        86,
        89,
        92,
        95,
        98,
        101,
        104,
        107,
        110,
        113,
        116,
        119,
        122,
        125,
        128,
    ]
    gradient = DimArray(Matrix(df[:, 2:end]), (Temp(ts), Press(ps)))
    generate_trace(gradient, Point2D(24, 1876.80005), 0.01, 1000)
end
