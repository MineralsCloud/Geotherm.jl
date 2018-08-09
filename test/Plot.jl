#=
LoadData:
- Julia version: 1.0
- Author: qz
- Date: 2018-08-09
=#

using GR

using GeoTherm: plot_trace, Point, Rectangle, bind

plot_trace(bind(Point(50.0, 50.0), Rectangle(0.0, 0.0, 100.0, 400.0); n=200))
GR.savefig("trace.pdf")