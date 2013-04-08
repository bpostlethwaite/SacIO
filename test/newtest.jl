require("../SacIO.jl")
using SacIO

macro test(expr)
    quote
    try
        @assert $expr
        println("  Pass:", $(string(expr)) )
    catch err
        println("  Fail: ", $(string(expr)) )
        println("  with: ", err )
    end
    end
end


file = "e.sac"
fstream = open(file)
d = readsac(fstream)
close(fstream)
println( d["npts"] )
println( d["delta"] )
println( d["knetwk"] )
println( d["kstnm"] )
