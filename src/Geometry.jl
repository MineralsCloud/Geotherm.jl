"""
# module Geometry



# Examples

```jldoctest
julia>
```
"""
module Geometry

export CartesianCoordinates, Rectangle, rectangle_to_points, within_rectangle

CartesianCoordinates(x::T) where T <: Real = NamedTuple{tuple(:x), Tuple{T}}((x))
CartesianCoordinates(x::T, y::T) where T <: Real = NamedTuple{(:x, :y), Tuple{T, T}}((x, y))
CartesianCoordinates(x::T, y::T, z::T) where T <: Real = NamedTuple{(:x, :y, :z), Tuple{T, T, T}}((x, y, z))

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

function rectangle_to_points(rec::Rectangle{T})::NTuple{4, Point{T}} where T <: Real
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    Point(lx, ly), Point(lx, uy), Point(rx, ly), Point(rx, uy)
end

function within_rectangle(rec::Rectangle{T}, c::CartesianCoordinates(::T, ::T))::Bool where T <: Real
    lx, rx, ly, uy = rec.lx, rec.rx, rec.ly, rec.uy
    lx <= c.x <= rx && ly <= c.y <= uy
end

end