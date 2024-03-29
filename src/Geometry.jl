module Geometry

export Point, Point2D, Point3D, Rectangle, vertices

abstract type Point{N,T} end
"""
    Point2D(x, y)

Generate a two-dimensional point.
"""
struct Point2D{T} <: Point{2,T}
    x::T
    y::T
end
function Point2D(x, y)
    T = Base.promote_typeof(x, y)
    return Point2D{T}(x, y)
end
struct Point3D{T} <: Point{3,T}
    x::T
    y::T
    z::T
end
"""
    Point3D(x, y, z)

Generate a three-dimensional point.
"""
function Point3D(x, y, z)
    T = Base.promote_typeof(x, y, z)
    return Point3D{T}(x, y, z)
end

"""
    Rectangle(lx, rx, ly, uy)

Generate a rectangle from its four corner points.
"""
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

"""
    vertices(rec::Rectangle)

Return four corner points of a `Rectangle`.
"""
function vertices(rec::Rectangle)
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    return Point2D(lx, ly), Point2D(lx, uy), Point2D(rx, ly), Point2D(rx, uy)
end

"""
    Base.in(p::Point2D, rec::Rectangle)

Test if point `p` is in rectangle `rec`.
"""
function Base.in(p::Point2D, rec::Rectangle)
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    return lx <= p.x <= rx && ly <= p.y <= uy
end

end
