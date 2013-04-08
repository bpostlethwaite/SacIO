load("test")
using Test

@test_fails assert(3==4)

a = {"A"=>1, "B"=>2}

type Sac

    header::Dict

end

sac = Sac(a)

println(sac.header["A"])

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



data = Any[i*3 for i = 1:length(floatKey)]

d = {floatKey[i] => data[i] for i = 1:length(floatKey)}


println(length(floatKey) + length(intKey) + length(charKey))

show( d )
println(typeof(d))
