"""
# module Interpolate



# Examples

```jldoctest
julia>
```
"""
module Interpolate

using Geotherm.Geometry: Point, Rectangle, SurfacePoint, Mapping, rectangle_to_points, within_rectangle

export linear_interpolate, bilinear_interpolate

"""
    inear_interpolate(a::Mapping, b::Mapping)

Return a function of the linear interpolation between any 2 abstract data points `(x1, f(x1))` and `(x2, g(x2))`.
"""
function linear_interpolate(a::Mapping, b::Mapping)::Function
    x1, x2, y1, y2 = a.x, b.x, a.y, b.y
    x1 != x2 || error("The x-coordinates of the 2 arguments `a` and `b` cannot be equal!")

    x -> ((x2 - x) * y1 + (x - x1) * y2) / (x2 - x1)
end

"""
    bilinear_interpolate(q11, q12, q21, q22)

If 4 points consisting of a rectangle and their z-coordinates are known, return a bilinear interpolation of
the 4 points.
"""
function bilinear_interpolate(q11::T, q12::T, q21::T, q22::T)::Function where T <: SurfacePoint
    x1, x2, y1, y2 = q11.x, q21.x, q11.y, q22.y
    v11, v12, v21, v22 = q11.z, q12.z, q21.z, q22.z
    rec = Rectangle(x1, y1, x2, y2)

    function (x, y)
        within_rectangle(rec, Point(x, y)) || error("The point ($x, $y) is out of boundary $rec!")
        v1 = linear_interpolate(Mapping(x1, v11), Mapping(x2, v21))(x)
        v2 = linear_interpolate(Mapping(x1, v12), Mapping(x2, v22))(x)
        linear_interpolate(Mapping(y1, v1), Mapping(y2, v2))(y)
    end
end

end
