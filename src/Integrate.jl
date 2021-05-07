module Integrate

using Geotherm.Geometry: Point2D

export runge_kutta

# This is a helper function and should not be exported.
function runge_kutta_iter(p::Point2D, f, h = 0.01)
    x, y = p.x, p.y
    k1 = h * f(x, y)
    k2 = h * f(x + h / 2, y + k1 / 2)
    k3 = h * f(x + h / 2, y + k2 / 2)
    k4 = h * f(x + h, y + k3)
    return Point2D(x + h, y + (k1 + 2 * k2 + 2 * k3 + k4) / 6)
end

function runge_kutta(p0::Point2D, f, h = 0.01, n = 1000)
    trace = Point2D[p0]
    for i in 1:(n-1)
        p_next = runge_kutta_iter(trace[i], f, h)
        push!(trace, p_next)
    end
    return trace
end

end
