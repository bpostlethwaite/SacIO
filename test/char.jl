f = open("char.sac", "w")


# fa = Array(Float32, 6)
# fa[1:6] = [1.2345, 2.3456, 3.4567, 45.678, 5.6789, 6.7890]
# for i in fa
#     write(f, i)
# end

# ia = Array(Int32, 6)
# ia[1:6] = [12345, 23456, 34567, 45678, 56789, 67890]
# for i in ia
#     write(f, i)
# end

ca = (join(["HELLO","BOUGH","SPOOK","PINTS","TRUSK"]))
println(ca)
println(ints(ca))
write(f, int(ca) )


close(f)

f = open("char.sac")

# floatdata = read(f, Float32, length(fa) )
# println(length(fa))
# println(floatdata)


# intdata = read(f, Int32, length(ia) )
# println(length(ia))
# println(intdata)

chardata = read(f, Char, length(ca) )

println( chardata )

# @assert floatdata == fa
# @assert intdata == ia
@assert chardata == ca
