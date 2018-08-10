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

using Geometry: Point, Rectangle
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
        i, j = promote(1.0, find_nearest(ts, trace[k].x), find_nearest(ps, trace[k].y))
        @show i, j
        rec_next = Rectangle(i, j, i + 1, j + 1)
        p_next = runge_kutta_iter(trace[k], bilinear_interpolate(rec_next), h)
        push!(trace, p_next)
    end
    trace
end

end