"""
# module Interpolate



# Examples

```jldoctest
julia>
```
"""
module Interpolate

using Geotherm.Geometry: Point2D, Point3D, Rectangle

export linear_interpolate, bilinear_interpolate

"""
    linear_interpolate(a, b)

Return a function of the linear interpolation between any 2 points `(x1, f(x1))` and `(x2, g(x2))`.
"""
function linear_interpolate(a::Point2D, b::Point2D)
    x1, y1, x2, y2 = a.x, a.y, b.x, b.y
    @assert x1 != x2 "The x-coordinates of the 2 arguments `a` and `b` cannot be equal!"
    return x -> ((x2 - x) * y1 + (x - x1) * y2) / (x2 - x1)
end

"""
    bilinear_interpolate(q11, q12, q21, q22)

If 4 points consisting of a rectangle and their z-coordinates are known, return a bilinear interpolation of
the 4 points.
"""
function bilinear_interpolate(q11::T, q12::T, q21::T, q22::T) where {T<:Point3D}
    x1, x2, y1, y2 = q11.x, q21.x, q11.y, q22.y
    z11, z12, z21, z22 = map(q -> q.z, (q11, q12, q21, q22))
    rec = Rectangle(x1, y1, x2, y2)
    return function (x, y)
        if Point2D(x, y) ∉ rec
            error("point ($x, $y) is out of boundary $rec.")
        end
        v1 = linear_interpolate(Point2D(x1, z11), Point2D(x2, z21))(x)
        v2 = linear_interpolate(Point2D(x1, z12), Point2D(x2, z22))(x)
        return linear_interpolate(Point2D(y1, v1), Point2D(y2, v2))(y)
    end
end

end
