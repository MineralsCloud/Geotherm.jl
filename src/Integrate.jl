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

import data: Point

export runge_kutta

function runge_kutta(p0::Point{T}, f::Function; h=0.01) where T <: Real
    x0, y0 = p0.x, p0.y
    k1 = h * f(x0, y0)
    k2 = h * f(x0 + h / 2, y0 + k1 / 2)
    k3 = h * f(x0 + h / 2, y0 + k2 / 2)
    k4 = h * f(x0 + h, y0 + k3)
    Point(x0 + h, y0 + (k1 + 2 * k2 + 2 * k3 + k4) / 6)
end

end