module Geotherm

include("Geometry.jl")
include("Interpolate.jl")
include("Integrate.jl")

using BisectPy: find_le
using DataFrames: DataFrame
using DimensionalData: AbstractDimMatrix, Dim, dims

using Geotherm.Geometry: Point2D, Point3D, Rectangle
using Geotherm.Interpolate: bilinear_interpolate
using Geotherm.Integrate: runge_kutta_iter

export Temp, Press, generate_trace

# This is a helper function and should not be exported.
function inject_find_lower_bound(ps, ts, geothermal_gradient)
    return function (x, y)
        i, j = find_le(ps, x), find_le(ts, y)
        k, l = i + 1, j + 1
        interpolated_function = bilinear_interpolate(
            Point3D(ps[i], ts[j], geothermal_gradient[j, i]),  # Note the order of indices!
            Point3D(ps[i], ts[l], geothermal_gradient[l, i]),  # Note the order of indices!
            Point3D(ps[k], ts[j], geothermal_gradient[j, k]),  # Note the order of indices!
            Point3D(ps[k], ts[l], geothermal_gradient[l, k]),   # Note the order of indices!
        )
        return interpolated_function(x, y)
    end
end

const Temp = Dim{:Temperature}
const Press = Dim{:Pressure}
const Gradient = AbstractDimMatrix{T,<:Union{Tuple{Temp,Press},Tuple{Press,Temp}}} where {T}

function generate_trace(geothermal_gradient::Gradient, p0::Point2D, h = 0.01, n = 1000)
    ps, ts = dims(geothermal_gradient, (Press, Temp))
    trace = Point2D[p0]
    f = inject_find_lower_bound(ps, ts, geothermal_gradient)
    for i in 1:(n-1)
        push!(trace, runge_kutta_iter(trace[i], f, h))
    end
    return trace
end

end
