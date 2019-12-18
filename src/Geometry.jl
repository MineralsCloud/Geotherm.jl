"""
# module Geometry



# Examples

```jldoctest
julia>
```
"""
module Geometry

using ExtractMacro
using StaticArrays: FieldVector

import Base: in

export Point, Point2D, Point3D, Rectangle, rectangle_vertices, in

abstract type Point{N,Float64} <: FieldVector{N,Float64} end

struct Point2D <: Point{2,Float64}
    x::Float64
    y::Float64
end

struct Point3D <: Point{3,Float64}
    x::Float64
    y::Float64
    z::Float64
end

struct Rectangle{T<:Real}
    lx::T
    rx::T
    ly::T
    uy::T
    function Rectangle{T}(lx::T, rx::T, ly::T, uy::T) where {T<:Real}
        @assert(lx != rx, "The `lx` and `rx` arguments cannot be the same!")
        @assert(ly != uy, "The `ly` and `uy` arguments cannot be the same!")
        new(min(lx, rx), max(lx, rx), min(ly, uy), max(ly, uy))
    end
end
Rectangle(lx::T, rx::T, ly::T, uy::T) where {T<:Real} = Rectangle{T}(lx, rx, ly, uy)
Rectangle(rec::Rectangle{T}) where {T} = Rectangle(rec.lx, rec.rx, rec.ly, rec.uy)

function rectangle_vertices(rec::Rectangle{T})::NTuple{4,Point2D} where {T<:Real}
    @extract rec lx rx ly uy  # lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    return Point2D(lx, ly), Point2D(lx, uy), Point2D(rx, ly), Point2D(rx, uy)
end

function in(c::Point2D, rec::Rectangle{T})::Bool where {T<:Real}
    @extract rec lx rx ly uy
    return lx <= c.x <= rx && ly <= c.y <= uy
end

end
