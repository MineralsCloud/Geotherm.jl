module Geometry

using StaticArrays: FieldVector

export Point, Point2D, Point3D, Rectangle, vertices

abstract type Point{N,T} <: FieldVector{N,T} end

struct Point2D{T} <: Point{2,T}
    x::T
    y::T
end

struct Point3D{T} <: Point{3,T}
    x::T
    y::T
    z::T
end

struct Rectangle{T}
    lx::T
    rx::T
    ly::T
    uy::T
    function Rectangle(lx, rx, ly, uy)
        @assert lx != rx "The `lx` and `rx` arguments cannot be the same!"
        @assert ly != uy "The `ly` and `uy` arguments cannot be the same!"
        T = Base.promote_typeof(lx, rx, ly, uy)
        return new{T}(min(lx, rx), max(lx, rx), min(ly, uy), max(ly, uy))
    end
end
Rectangle(rec::Rectangle) = rec

function vertices(rec::Rectangle)
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    return Point2D(lx, ly), Point2D(lx, uy), Point2D(rx, ly), Point2D(rx, uy)
end

function Base.in(c::Point2D, rec::Rectangle)
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    return lx <= c.x <= rx && ly <= c.y <= uy
end

end
