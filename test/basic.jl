# Header tests.

# load("../julia.sac.jl")
# using SacIO

# load("harness")
# using Harness

# @test 3==3



function readsac(fstream)

    floatKey = ["delta","depmin","depmax","scale","odelta","b",
                "e","o","a","internal","t0","t1","t2","t3","t4","t5","t6",
                "t7","t8","t9","f","resp0","resp1","resp2","resp3","resp4",
                "resp5","resp6","resp7","resp8","resp9","stla","stlo",
                "stel","stdp","evla","evlo","evel","evdp","mag","user0",
                "user1","user2","user3","user4","user5","user6","user7",
                "user8","user9","dist","az","baz","gcarc","internal",
                "internal","depmen","cmpaz","cmpinc","xminimum","xmaximum",
                "yminimum","ymaximum","unused","unused","unused","unused",
                "unused","unused","unused"]

    intKey = ["nzyear","nzjday","nzhour","nzmin","nzsec","nzmsec","nvhdr",
              "norid","nevid","npts","internal","nwfid","nxsize","nysize",
              "unused","iftype","idep","iztype","unused","iinst","istreg",
              "ievreg","ievtyp","iqual","isynth","imagtyp","imagsrc","unused",
              "unused","unused","unused","unused","unused","unused","unused",
              "leven","lpspol","lovrok","lcalda","unused"]

    charKey = ["kstnm","kevnm","khole","ko","ka","kt0","kt1","kt2","kt3","kt4",
               "kt5","kt6","kt7","kt8","kt9","kf","kuser0","kuser1","kuser2",
               "kcmpnm","knetwk","kdatrd","kinst"]

    # Read in header information
    floatData = read(fstream, Float32, 70)
    intData = read(fstream, Int32, 40)
    charData = read(fstream, Int32, 192)

    # Build dictionaries and merge
    d = Dict{ASCIIString, Any}(133)
    fd = { floatKey[i] => floatData[i] for i = 1:length(floatKey) }
    id = { intKey[i] => intData[i] for i = 1:length(intKey) }
    j = 1
    for i = 1:length(charKey)
        if i == 2
            d[ charKey[i] ] = charData[j : j + 15]
            j += 16
        else
            d[ charKey[i] ] = charData[j : j + 7]
            j += 8
        end
    end

    d = merge(fd, id, d)


    # Extract number of points in data array
    # The position is defined in the SAC data format
    # npts = ints[10]
    # println("$npts")
    # data = read(fstream, Float32, npts)
    # println("$(typeof(data))")

end

file = "e.sac"
fstream = open(file)
d = readsac(fstream)
close(fstream)
println( d["npts"] )
println( d["delta"] )
println(d["knetwk"])
println( typeof(d) )


# runTest("Test one") do
#     file = "e.sac"
#     fstream = open(file)
#     d = readsac(fstream)
#     close(fstream)
#     println( d["npts"] )
#     println(d["knetwk"], " is ", typeof(string(join(d["knetwk"]))) )
#     println( typeof(d) )
# end
