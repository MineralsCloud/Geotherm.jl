"""
# module Interpolate



# Examples

```jldoctest
julia>
```
"""
module Interpolate

using Geotherm.Geometry: Rectangle, within_rectangle

export linear_interpolate, bilinear_interpolate

"""
    inear_interpolate(a::Pair, b::Pair)

Return a function of the linear interpolation between any 2 rule of assignments `(x1, f(x1))` and `(x2, g(x2))`.
"""
function linear_interpolate(a::Pair, b::Pair)::Function
    x1, x2 = map(x -> x.first, [a, b])
    y1, y2 = map(x -> x.second, [a, b])
    x1 != x2 || error("The x-coordinates of the 2 arguments `a` and `b` cannot be equal!")

    x -> ((x2 - x) * y1 + (x - x1) * y2) / (x2 - x1)
end

"""
    bilinear_interpolate(q11, q12, q21, q22)

If 4 points consisting of a rectangle and their z-coordinates are known, return a bilinear interpolation of
the 4 points.
"""
function bilinear_interpolate(q11::T, q12::T, q21::T, q22::T)::Function where T <: Pair{NamedTuple, Real}
    coordinates = map(x -> x.first, [q11, q21, q11, q22])
    x1, x2 = first.(coordinates[1:2])
    y1, y2 = last.(coordinates[3:4])
    v11, v12, v21, v22 = map(x -> x.second, [q11, q12, q21, q22])
    rec = Rectangle(x1, y1, x2, y2)

    function (x, y)
        within_rectangle(rec, Point(x, y)) || error("The point ($x, $y) is out of boundary $rec!")
        v1 = linear_interpolate(Pair(x1, v11), Pair(x2, v21))(x)
        v2 = linear_interpolate(Pair(x1, v12), Pair(x2, v22))(x)
        linear_interpolate(Pair(y1, v1), Pair(y2, v2))(y)
    end
end

end
