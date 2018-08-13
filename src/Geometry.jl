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

export Point, Rectangle, SurfacePoint, rectangle_to_points, within_rectangle

struct Point{T <: Real}
    x::T
    y::T
end

struct Rectangle{T <: Real}
    lx::T
    ly::T
    rx::T
    ry::T
    function Rectangle{T}(lx::T, ly::T, rx::T, ry::T) where T <: Real
        lx != rx || error("The `lx` and `rx` arguments cannot be the same!")
        ly != ry || error("The `ly` and `ry` arguments cannot be the same!")
        new(min(lx, rx), max(lx, rx), min(ly, ry), max(ly, ry))
    end
    Rectangle{T}(rec::Rectangle) where T <: Real = new(rec.lx, rec.ly, rec.rx, rec.ry)
end

Rectangle(lx::T, ly::T, rx::T, ry::T) where T <: Real = Rectangle{T}(lx, ly, rx, ry)

struct SurfacePoint{T <: Real}
    x::T
    y::T
    z::T
end

SurfacePoint(x::T, y::T, z::T) where T <: Real = SurfacePoint{T}(x, y, z)

function rectangle_to_points(rec::Rectangle{T})::NTuple{4, Point{T}} where T <: Real
    lx, rx, ly, ry = rec.lx, rec.ly, rec.rx, rec.ry
    Point(lx, ly), Point(lx, ry), Point(rx, ly), Point(rx, ry)
end

function within_rectangle(rec::Rectangle{T}, t::Point{T})::Bool where T <: Real
    lx, rx, ly, ry = rec.lx, rec.ly, rec.rx, rec.ry
    x, y = t.x, t.y
    lx <= x <= rx && ly <= y <= ry
end

function point_to_surface_point(p::Point{T}, z::T) where T <: Real
    SurfacePoint(p.x, p.y, z)
end

end