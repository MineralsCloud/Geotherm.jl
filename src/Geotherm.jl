"""
# module Geotherm



# Examples

```jldoctest
julia>
```
"""
module Geotherm

include("Geometry.jl")
include("Interpolate.jl")
include("Integrate.jl")

using BisectPy: bisect_right
using DataFrames: DataFrame

using Geotherm.Geometry: Point2D, Point3D, Rectangle
using Geotherm.Interpolate: bilinear_interpolate
using Geotherm.Integrate: runge_kutta_iter

export generate_trace

# This is a helper function and should not be exported.
find_lower_bounds(xs, ys) = (x, y) -> bisect_right(xs, x) - 1, bisect_right(ys, y) - 1

# This is a helper function and should not be exported.
function inject_find_lower_bound(ps, ts, geothermal_gradient)
    return function (x, y)
        m, n = find_lower_bounds(ps, ts)(x, y)
        o, p = m + 1, n + 1
        interpolated_function = bilinear_interpolate(
            Point3D(ps[m], ts[n], geothermal_gradient[n, m]),  # Note the order of indices!
            Point3D(ps[m], ts[p], geothermal_gradient[p, m]),  # Note the order of indices!
            Point3D(ps[o], ts[n], geothermal_gradient[n, o]),  # Note the order of indices!
            Point3D(ps[o], ts[p], geothermal_gradient[p, o]),   # Note the order of indices!
        )
        return interpolated_function(x, y)
    end
end

function generate_trace(geothermal_gradient::DataFrame, p0::Point2D, h = 0.01, n = 1000)
    ps = float(names(geothermal_gradient))
    ts = float(geothermal_gradient[Symbol("T(K)\\P(GPa)")])
    trace = Point2D[p0]
    f = inject_find_lower_bound(ps, ts, geothermal_gradient)
    for i in 1:(n-1)
        push!(trace, runge_kutta_iter(trace[i], f, h))
    end
    return trace
end

end
