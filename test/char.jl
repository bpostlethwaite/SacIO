f = open("char.sac", "w")

a = Array(Int32, 6)
a[1:6] = [12345,23456,34567,45678,56789,67890]
for i in a
    write(f, a)
end
close(f)

f = open("char.sac")
ints = read(f, Int32, length(a))

@assert a == ints

close(f)



f = open("char.sac", "w")

a = Array(ASCIIString, 5)

a = chars(join(["HELLO","BOUGH","SPOOK","PINTS","TRUSK"]))

for i in a
    write(f, a)
end

close(f)

f = open("char.sac")

c = read(f, Char, length(a))

println(c)

@assert a == c

close(f)