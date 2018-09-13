"""
# module Bind



# Examples

```jldoctest
julia> find_nearest(collect(1:10.0), 3.6)
4
```
"""
module Bind

using BisectPy: bisect_right
using DataFrames

using Geotherm.Geometry: Point, Rectangle, SurfacePoint
using Geotherm.Interpolate: bilinear_interpolate
using Geotherm.Integrate: runge_kutta_iter

export find_lower_bounds, inject_find_lower_bound, generate_trace

function find_lower_bounds(xs, ys)::Function
    (x, y) -> bisect_right(xs, x) - 1, bisect_right(ys, y) - 1
end

function inject_find_lower_bound(ps, ts, geothermal_gradient)
    function (x, y)
        m, n = find_lower_bounds(ps, ts)(x, y)
        o, p = m + 1, n + 1
        interpolated_function = bilinear_interpolate(
            SurfacePoint(ps[m], ts[n], geothermal_gradient[n, m]),  # Note the order of indices!
            SurfacePoint(ps[m], ts[p], geothermal_gradient[p, m]),  # Note the order of indices!
            SurfacePoint(ps[o], ts[n], geothermal_gradient[n, o]),  # Note the order of indices!
            SurfacePoint(ps[o], ts[p], geothermal_gradient[p, o])  # Note the order of indices!
        )
        interpolated_function(x, y)
    end
end

function generate_trace(geothermal_gradient::DataFrame, p0::Point{T}, h=0.01, n=1000) where T <: Real
    ps = float(names(geothermal_gradient))
    ts = float(geothermal_gradient[Symbol("T(K)\P(GPa)")])

    trace = Point{T}[]
    push!(trace, p0)
    f = inject_find_lower_bound(ps, ts, geothermal_gradient)
    for i = 1:(n - 1)
        push!(trace, runge_kutta_iter(trace[i], f, h))
    end
    trace
end

end