"""
# module Integrate

- Julia version: 1.0
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module Integrate

import Geometry: Point

export runge_kutta_iter, runge_kutta

function runge_kutta_iter(p::Point{T}, f::Function, h=0.01) where T <: Real
    x, y = p.x, p.y
    k1 = h * f(x, y)
    k2 = h * f(x + h / 2, y + k1 / 2)
    k3 = h * f(x + h / 2, y + k2 / 2)
    k4 = h * f(x + h, y + k3)
    Point(x + h, y + (k1 + 2 * k2 + 2 * k3 + k4) / 6)
end

function runge_kutta(p0::Point{T}, f::Function, h=0.01; nstep=1000) where T <: Real
    trace = Point{T}[p0]
    for i in 1:nstep-1
        p_next = runge_kutta_iter(trace[i], f)
        push!(trace, p_next)
    end
    trace
end

end