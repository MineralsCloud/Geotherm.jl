"""
# module Geometry



# Examples

```jldoctest
julia>
```
"""
module Geometry

using StaticArrays: FieldVector

import Base: in

export Point, Point2D, Point3D,
    Rectangle, rectangle_to_points, within_rectangle,
    in

abstract type Point{N, Float64} <: FieldVector{N, Float64} end

struct Point2D <: Point{2, Float64}
    x::Float64
    y::Float64
end

struct Point3D <: Point{3, Float64}
    x::Float64
    y::Float64
    z::Float64
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

function rectangle_to_points(rec::Rectangle{T})::NTuple{4, Point2D} where T <: Real
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    Point2D(lx, ly), Point2D(lx, uy), Point2D(rx, ly), Point2D(rx, uy)
end

function in(c::Point2D, rec::Rectangle{T})::Bool where T <: Real
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    lx <= c.x <= rx && ly <= c.y <= uy
end

end