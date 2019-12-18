"""
# module Interpolate



# Examples

```jldoctest
julia>
```
"""
module Interpolate

using ExtractMacro

using Geotherm.Geometry: Point2D, Point3D, Rectangle

export linear_interpolate, bilinear_interpolate

"""
    linear_interpolate(a, b)

Return a function of the linear interpolation between any 2 points `(x1, f(x1))` and `(x2, g(x2))`.
"""
function linear_interpolate(a::Point2D, b::Point2D)::Function
    @extract a x1 = x y1 = y  # x1, y1 = a.x, a.y
    @extract b x2 = x y2 = y  # x2, y2 = b.x, b.y
    @assert(x1 != x2, "The x-coordinates of the 2 arguments `a` and `b` cannot be equal!")
    return x -> ((x2 - x) * y1 + (x - x1) * y2) / (x2 - x1)
end
linear_interpolate(a::NTuple{2,Float64}, b::NTuple{2,Float64}) =
    linear_interpolate(Point2D(a), Point2D(b))

"""
    bilinear_interpolate(q11, q12, q21, q22)

If 4 points consisting of a rectangle and their z-coordinates are known, return a bilinear interpolation of
the 4 points.
"""
function bilinear_interpolate(q11::T, q12::T, q21::T, q22::T)::Function where {T<:Point3D}
    x1, x2 = q11.x, q21.x
    y1, y2 = q11.y, q22.y
    z11, z12, z21, z22 = [q11, q12, q21, q22] |> (q -> q.z)
    rec = Rectangle(x1, y1, x2, y2)
    return function (x, y)
        Point2D(x, y) in rec || error("The point ($x, $y) is out of boundary $rec!")
        v1 = linear_interpolate((x1, z11), (x2, z21))(x)
        v2 = linear_interpolate((x1, z12), (x2, z22))(x)
        linear_interpolate((y1, v1), (y2, v2))(y)
    end
end

end
