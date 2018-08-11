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

linear_interpolate(a, b, f, g)::Function = x -> ((b - x) * f + (x - a) * g) / (b - a)

function bilinear_interpolate(p::Manifold, q::Manifold, r::Manifold, s::Manifold)::Function
    x1, x2, y1, y2 = p.p.x, q.p.x, p.p.y, q.p.y
    f11, f21, f12, f22 = p.z, q.z, r.z, s.z
    rec = Rectangle(x1, x2, y1, y2)
    function (x, y)
        within_rectangle(rec, Point(x, y)) || error("The point ($x, $y) is out of boundary!")
        f1 = linear_interpolate(x1, x2, f11, f21)
        f2 = linear_interpolate(x1, x2, f12, f22)
        linear_interpolate(y1, y2, f1(x), f2(x))(y)
    end
end

end
