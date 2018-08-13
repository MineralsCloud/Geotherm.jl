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

using Geometry: Point, Rectangle, SurfacePoint
using Interpolate: bilinear_interpolate
using Integrate: runge_kutta_iter

import Base.bind

export bind

function find_nearest(arr::Vector{T}, x::T)::Integer where T <: Real
    argmin(abs.(arr .- x))
end

function bind(p0::Point{T}, ts::Vector{T}, ps::Vector{T}, h=0.01, n=1000) where T <: Real
    trace = Point{T}[p0]
    for k in 1:(n - 1)
        i, j = find_nearest(ts, trace[k].x), find_nearest(ps, trace[k].y)
        p_next = runge_kutta_iter(trace[k], bilinear_interpolate(
            SurfacePoint(Point(ts[i], ps[j]), adiabat[i, j]),
            SurfacePoint(Point(ts[i+1], ps[j]), adiabat[i+1, j]),
            SurfacePoint(Point(ts[i], ps[j+1]), adiabat[i, j+1]),
            SurfacePoint(Point(ts[i+1], ps[j+1]), adiabat[i+1, j+1])
        ), h)
        push!(trace, p_next)
    end
    trace
end

end