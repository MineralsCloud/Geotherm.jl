"""
# module data

- Julia version: 0.7
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module data

export Point, Rectangle, rectangle_to_points

struct Point{T <: Real}
    x::T
    y::T
end

struct Rectangle{T <: Real}
    lx::T
    ly::T
    rx::T
    ry::T
    Rectangle{T}(lx::T, ly::T, rx::T, ry::T) where T <: Real =
        new(min(lx, rx), max(lx, rx), min(ly, ry), max(ly, ry))
    Rectangle{T}(rec::Rectangle) where T <: Real = new(rec.lx, rec.ly, rec.rx, rec.ry)
end

Rectangle(lx::T, ly::T, rx::T, ry::T) where T <: Real = Rectangle{T}(lx, ly, rx, ry)

function rectangle_to_points(rec::Rectangle{T}) where T <: Real
    lx, rx, ly, ry = rec.lx, rec.ly, rec.rx, rec.ry
    Point(lx, ly), Point(lx, ry), Point(rx, ly), Point(rx, ry)
end

end