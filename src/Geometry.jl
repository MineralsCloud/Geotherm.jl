"""
# module Geometry

- Julia version: 1.0
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module Geometry

export Point, Rectangle, Manifold, rectangle_to_points, within_rectangle

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

struct Manifold{T <: Real}
    p::Point{T}
    z::T
end

function rectangle_to_points(rec::Rectangle{T})::NTuple{4, Point{T}} where T <: Real
    lx, rx, ly, ry = rec.lx, rec.ly, rec.rx, rec.ry
    Point(lx, ly), Point(lx, ry), Point(rx, ly), Point(rx, ry)
end

function within_rectangle(rec::Rectangle{T}, t::Point{T})::Bool where T <: Real
    lx, rx, ly, ry = rec.lx, rec.ly, rec.rx, rec.ry
    x, y = t.x, t.y
    lx < x < rx && ly < y < ry
end

end