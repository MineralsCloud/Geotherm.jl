module Geotherm

include("Geometry.jl")
include("Interpolate.jl")
include("Integrate.jl")

using BisectPy: bisect_right
import DimensionalData  # Need to load this to run code
using DimensionalData: AbstractDimMatrix, dims, @dim

using Geotherm.Geometry: Point2D, Point3D, Rectangle
using Geotherm.Interpolate: bilinear_interpolate
using Geotherm.Integrate: runge_kutta_iter

export Temp, Press, generate_trace

# This is different from `BisectPy.find_le`, which returns the value!
function find_le(a, x)
    i = bisect_right(a, x)
    return i > 1 ? i - 1 : nothing
end

# This is a helper function and should not be exported.
function inject_find_lower_bound(ps, ts, geothermal_gradient)
    return function (p, t)
        i, j = find_le(ps, p), find_le(ts, t)
        k, l = i + 1, j + 1
        interpolated_function = bilinear_interpolate(
            Point3D(ps[i], ts[j], geothermal_gradient[j, i]),  # Note the order of indices!
            Point3D(ps[i], ts[l], geothermal_gradient[l, i]),  # Note the order of indices!
            Point3D(ps[k], ts[j], geothermal_gradient[j, k]),  # Note the order of indices!
            Point3D(ps[k], ts[l], geothermal_gradient[l, k]),   # Note the order of indices!
        )
        return interpolated_function(p, t)
    end
end

@dim Temp "Temperature"
@dim Press "Pressure"

"""
    generate_trace(geothermal_gradient::AbstractDimMatrix, p0::Point2D, h=0.01, n=1000)

Generate a trace of `Point`s specifiying pressure and temperature.
"""
function generate_trace(
    geothermal_gradient::AbstractDimMatrix{T,<:Tuple{Temp,Press}},
    p0::Point2D,
    h = 0.01,
    n = 1000,
) where {T}
    ps, ts = dims(geothermal_gradient, (Press, Temp))
    trace = Point2D[p0]
    f = inject_find_lower_bound(ps, ts, geothermal_gradient)
    for i in 1:(n-1)
        push!(trace, runge_kutta_iter(trace[i], f, h))
    end
    return trace
end
generate_trace(
    geothermal_gradient::AbstractDimMatrix{T,<:Tuple{Press,Temp}},
    p0::Point2D,
    h = 0.01,
    n = 1000,
) where {T} = generate_trace(geothermal_gradient', p0, h, n)

end
