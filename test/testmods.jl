
function bard()
    count = 0
    return inc -> count = count + inc
end

c = bard()
d = bard()

c(1)
c(1)


println("$(c(1))")
#macro testblock(name)
#    quote
#        module $name
#        import Base.*
#        a = 2
#        end
#    end
#end
