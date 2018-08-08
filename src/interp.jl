"""
# module interp

- Julia version: 0.7
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module interp

include("data.jl")
using data: Point, Rectangle, rectangle_to_points

export within_boundary, linear_interpolate, bilinear_interpolate

function linear_interpolate(a::Point{T}, b::Point{T}) where T <: Real
    x1, x2, y1, y2 = a.x, b.x, a.y, b.y
    x -> ((x2 - x) * y1 + (x - x1) * y2) / (x2 - x1)
end

function within_boundary(rec::Rectangle{T}, t::Point{T}) where T <: Real
    lx, rx, ly, ry = rec.lx, rec.ly, rec.rx, rec.ry
    x, y = t.x, t.y
    lx < x < rx && ly < y < ry
end

function bilinear_interpolate(rec::Rectangle{T}) where T <: Real
    function (x, y)
        within_boundary(rec, Point(x, y)) || error("The point is out of boundary!")
        a, b, c, d = rectangle_to_points(rec)
        y1, y2 = a.y, b.y
        f1 = linear_interpolate(a, c)
        f2 = linear_interpolate(b, d)
        ((y2 - y) * f1(x) + (y - y1) * f2(x)) / (y2 - y1)
    end
end

end
