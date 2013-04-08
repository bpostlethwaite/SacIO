include("../julia.sac.jl")

import Base.*

macro testblock(testname)
    println("--- --- ---")
    println("Testing $testname")
end

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

macro consts(exps)
    block = {}
    for exp in exps.args
        if typeof(exp) != LineNumberNode
            push(block, Expr(:const, {esc(exp)}, Any))
        end
    end
    Expr(:block, block, Any)
end

@consts begin
x = 3
y = 4
end

macro testblock(name)
    quote
        module $name
        a = 2
        end
    end
end



@testblock "SacType"
begin
    local n = int32(512)
    local h = Header( n )
    local sac = Sac( h, float32( Base.randn( int64(n) ) ) )
    #println("$(typeof(sac.data1))")
    @assert isa(sac.data1, Array{Float32, 1})
    @test 3 == 3
    @test 3 == 2
end


@testblock "readsac"
begin
    local file = "z.sac"
    local const fstream = open(file)
    close(fstream)
end
