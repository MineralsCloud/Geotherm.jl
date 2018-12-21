"""
# module Integrate



# Examples

```jldoctest
julia>
```
"""
module Integrate

using Geotherm.Geometry: Point2D

export runge_kutta_iter, runge_kutta

function runge_kutta_iter(p::Point2D, f::Function, h=0.01)
    x, y = p.x, p.y
    k1 = h * f(x, y)
    k2 = h * f(x + h / 2, y + k1 / 2)
    k3 = h * f(x + h / 2, y + k2 / 2)
    k4 = h * f(x + h, y + k3)
    Point2D(x + h, y + (k1 + 2 * k2 + 2 * k3 + k4) / 6)
end

function runge_kutta(p0::Point2D, f::Function, h=0.01, n=1000)
    trace = Point2D[p0]
    for i in 1:(n - 1)
        p_next = runge_kutta_iter(trace[i], f)
        push!(trace, p_next)
    end
    trace
end

end