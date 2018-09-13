"""
# module Geometry



# Examples

```jldoctest
julia>
```
"""
module Geometry

export Point, Rectangle, SurfacePoint, Mapping, rectangle_to_points, within_rectangle

abstract type AbstractPoint end

struct Point{T <: Real} <: AbstractPoint
    x::T
    y::T
end

struct Mapping <: AbstractPoint
    x
    y
end

struct Rectangle{T <: Real}
    lx::T
    rx::T
    ly::T
    uy::T
    function Rectangle{T}(lx::T, rx::T, ly::T, uy::T) where T <: Real
        lx != rx || error("The `lx` and `rx` arguments cannot be the same!")
        ly != uy || error("The `ly` and `uy` arguments cannot be the same!")
        new(min(lx, rx), max(lx, rx), min(ly, uy), max(ly, uy))
    end
    Rectangle{T}(rec::Rectangle) where T <: Real = new(rec.lx, rec.rx, rec.ly, rec.uy)
end

Rectangle(lx::T, rx::T, ly::T, uy::T) where T <: Real = Rectangle{T}(lx, rx, ly, uy)

struct SurfacePoint{T <: Real}
    x::T
    y::T
    z::T
end

SurfacePoint(x::T, y::T, z::T) where T <: Real = SurfacePoint{T}(x, y, z)

function rectangle_to_points(rec::Rectangle{T})::NTuple{4, Point{T}} where T <: Real
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    Point(lx, ly), Point(lx, uy), Point(rx, ly), Point(rx, uy)
end

function within_rectangle(rec::Rectangle{T}, p::Point{T})::Bool where T <: Real
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    x, y = p.x, p.y
    lx <= x <= rx && ly <= y <= uy
end

end