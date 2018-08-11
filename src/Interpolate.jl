"""
# module Interpolate

- Julia version: 1.0
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module Interpolate

using Geometry: Point, Rectangle, Manifold, rectangle_to_points, within_rectangle

export bilinear_interpolate

"""
    linear_interpolate(a, b, f, g)

Return a function of the linear interpolation between any 2 abstract data points `(a, f)` and `(b, g)`.
"""
linear_interpolate(a, b, f, g)::Function = x -> ((b - x) * f + (x - a) * g) / (b - a)

"""
    bilinear_interpolate(p, q, r, s)

If 4 points consisting of a rectangle and their z-coordinates are known, return a bilinear interpolation of
the 4 points.
"""
function bilinear_interpolate(p::Manifold, q::Manifold, r::Manifold, s::Manifold)::Function
    x1, x2, y1, y2 = p.p.x, q.p.x, p.p.y, q.p.y
    z1, z2, z3, z4 = p.z, q.z, r.z, s.z
    rec = Rectangle(x1, x2, y1, y2)
    function (x, y)
        within_rectangle(rec, Point(x, y)) || error("The point ($x, $y) is out of boundary!")
        f1 = linear_interpolate(x1, x2, z1, z2)
        f2 = linear_interpolate(x1, x2, z3, z4)
        linear_interpolate(y1, y2, f1(x), f2(x))(y)
    end
end

end
