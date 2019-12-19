"""
# module Geometry



# Examples

```jldoctest
julia>
```
"""
module Geometry

using ExtractMacro: @extract
using StaticArrays: FieldVector

export Point, Point2D, Point3D, Rectangle, rectangle_vertices

abstract type Point{N,T} <: FieldVector{N,T<:Real} end

struct Point2D <: Point{2,T}
    x::T
    y::T
end

struct Point3D <: Point{3,T}
    x::T
    y::T
    z::T
end

struct Rectangle{T<:Real}
    lx::T
    rx::T
    ly::T
    uy::T
    function Rectangle{T}(lx::T, rx::T, ly::T, uy::T) where {T}
        @assert(lx != rx, "The `lx` and `rx` arguments cannot be the same!")
        @assert(ly != uy, "The `ly` and `uy` arguments cannot be the same!")
        return new(min(lx, rx), max(lx, rx), min(ly, uy), max(ly, uy))
    end
end
Rectangle(lx::T, rx::T, ly::T, uy::T) where {T} = Rectangle{T}(lx, rx, ly, uy)
Rectangle(rec::Rectangle) = Rectangle(rec.lx, rec.rx, rec.ly, rec.uy)

function rectangle_vertices(rec::Rectangle)
    @extract rec lx rx ly uy  # lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    return Point2D(lx, ly), Point2D(lx, uy), Point2D(rx, ly), Point2D(rx, uy)
end

function Base.in(c::Point2D, rec::Rectangle)
    @extract rec lx rx ly uy
    return lx <= c.x <= rx && ly <= c.y <= uy
end

end
