"""
# module Bind

- Julia version: 1.0
- Author: qz
- Date: 2018-08-09

# Examples

```jldoctest
julia> find_nearest(collect(1:10.0), 3.6)
4
```
"""
module Bind

using Geometry: Point, Rectangle, SurfacePoint, point_to_surface_point
using Interpolate: bilinear_interpolate
using Integrate: runge_kutta_iter

import Base.bind

export bind

function find_nearest(arr::Vector{T}, x::T)::Integer where T <: Real
    argmin(abs.(arr .- x))
end

function bind(adiabat::Matrix{T}, ts::Vector{T}, ps::Vector{T}, p0::Point{T}, h=0.01, n=1000) where T <: Real
    trace = Point{T}[p0]
    for k in 1:(n - 1)
        i, j = find_nearest(ts, trace[k].x), find_nearest(ps, trace[k].y)
        f = bilinear_interpolate(
            point_to_surface_point(Point(ts[i], ps[j]), adiabat[i, j]),
            point_to_surface_point(Point(ts[i], ps[j+3]), adiabat[i, j+3]),
            point_to_surface_point(Point(ts[i+3], ps[j]), adiabat[i+3, j]),
            point_to_surface_point(Point(ts[i+3], ps[j+3]), adiabat[i+3, j+3])
        )
        p_next = runge_kutta_iter(trace[k], f, h)
        push!(trace, p_next)
    end
    trace
end

end