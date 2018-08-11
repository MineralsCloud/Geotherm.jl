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
    bilinear_interpolate(q11, q12, q21, q22)

If 4 points consisting of a rectangle and their z-coordinates are known, return a bilinear interpolation of
the 4 points.
"""
function bilinear_interpolate(q11::Manifold, q12::Manifold, q21::Manifold, q22::Manifold)::Function
    x1, x2, y1, y2 = q11.p.x, q21.p.x, q11.p.y, q22.p.y
    v11, v12, v21, v22 = q11.z, q12.z, q21.z, q22.z
    rec = Rectangle(x1, y1, x2, y2)
    function (x, y)
        within_rectangle(rec, Point(x, y)) || error("The point ($x, $y) is out of boundary!")
        v1 = linear_interpolate(x1, x2, v11, v21)(x)
        v2 = linear_interpolate(x1, x2, v12, v22)(x)
        linear_interpolate(y1, y2, v1, v2)(y)
    end
end

end
