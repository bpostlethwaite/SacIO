module SacIO
# Julia-sac-IO
# Ben Postlethwaite December - 2012

export Sac, SacA, SacB, readsac


abstract Sac

type SacA <: Sac
  header::Dict{Any, Any}
  data::Array{Float32, 1}
end

type SacB <: Sac
  header::Dict{Any, Any}
  data::Array{Float32, 1}
end

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
    charData = read(fstream, Uint8, 192)

    # Build dictionaries and merge
    d = Dict{Any, Any}()
    fd = { floatKey[i] => floatData[i] for i = 1:length(floatKey) }
    id = { intKey[i] => intData[i] for i = 1:length(intKey) }
    j = 1
    for i = 1:length(charKey)
        if i == 2
            d[ charKey[i] ] = ascii(charData[j : j + 15])
            j += 16
        else
            d[ charKey[i] ] = ascii(charData[j : j + 7])
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


end # module


# .. _SacIris: http://www.iris.edu/manuals/sac/SAC_Manuals/FileFormatPt2.html

#     ============ ==== =========================================================
#     Field Name   Type Description
#     ============ ==== =========================================================
#     npts         N    Number of points per data component. [required]
#     nvhdr        N    Header version number. Current value is the integer 6.
#                       Older version data (NVHDR < 6) are automatically updated
#                       when read into sac. [required]
#     b            F    Beginning value of the independent variable. [required]
#     e            F    Ending value of the independent variable. [required]
#     iftype       I    Type of file [required]:
#                           * ITIME {Time series file}
#                           * IRLIM {Spectral file---real and imaginary}
#                           * IAMPH {Spectral file---amplitude and phase}
#                           * IXY {General x versus y data}
#                           * IXYZ {General XYZ (3-D) file}
#     leven        L    TRUE if data is evenly spaced. [required]
#     delta        F    Increment between evenly spaced samples (nominal value).
#                       [required]
#     odelta       F    Observed increment if different from nominal value.
#     idep         I    Type of dependent variable:
#                           * IUNKN (Unknown)
#                           * IDISP (Displacement in nm)
#                           * IVEL (Velocity in nm/sec)
#                           * IVOLTS (Velocity in volts)
#                           * IACC (Acceleration in nm/sec/sec)
#     scale        F    Multiplying scale factor for dependent variable
#                       [not currently used]
#     depmin       F    Minimum value of dependent variable.
#     depmax       F    Maximum value of dependent variable.
#     depmen       F    Mean value of dependent variable.
#     nzyear       N    GMT year corresponding to reference (zero) time in file.
#     nyjday       N    GMT julian day.
#     nyhour       N    GMT hour.
#     nzmin        N    GMT minute.
#     nzsec        N    GMT second.
#     nzmsec       N    GMT millisecond.
#     iztype       I    Reference time equivalence:
#                           * IUNKN (Unknown)
#                           * IB (Begin time)
#                           * IDAY (Midnight of refernece GMT day)
#                           * IO (Event origin time)
#                           * IA (First arrival time)
#                           * ITn (User defined n=0 time 9) pick n
#     o            F    Event origin time (seconds relative to reference time.)
#     a            F    First arrival time (seconds relative to reference time.)
#     ka           K    First arrival time identification.
#     f            F    Fini or end of event time (seconds relative to reference
#                       time.)
#     tn           F    User defined time {ai n}=0,9 (seconds picks or markers
#                       relative to reference time).
#     kt{ai n}     K    A User defined time {ai n}=0,9.  pick identifications
#     kinst        K    Generic name of recording instrument
#     iinst        I    Type of recording instrument. [currently not used]
#     knetwk       K    Name of seismic network.
#     kstnm        K    Station name.
#     istreg       I    Station geographic region. [not currently used]
#     stla         F    Station latitude (degrees, north positive)
#     stlo         F    Station longitude (degrees, east positive).
#     stel         F    Station elevation (meters). [not currently used]
#     stdp         F    Station depth below surface (meters). [not currently
#                       used]
#     cmpaz        F    Component azimuth (degrees, clockwise from north).
#     cmpinc       F    Component incident angle (degrees, from vertical).
#     kcmpnm       K    Component name.
#     lpspol       L    TRUE if station components have a positive polarity
#                       (left-hand rule).
#     kevnm        K    Event name.
#     ievreg       I    Event geographic region. [not currently used]
#     evla         F    Event latitude (degrees north positive).
#     evlo         F    Event longitude (degrees east positive).
#     evel         F    Event elevation (meters). [not currently used]
#     evdp         F    Event depth below surface (meters). [not currently used]
#     mag          F    Event magnitude.
#     imagtyp      I    Magnitude type:
#                           * IMB (Bodywave Magnitude)
#                           * IMS (Surfacewave Magnitude)
#                           * IML (Local Magnitude)
#                           * IMW (Moment Magnitude)
#                           * IMD (Duration Magnitude)
#                           * IMX (User Defined Magnitude)
#     imagsrc      I    Source of magnitude information:
#                           * INEIC (National Earthquake Information Center)
#                           * IPDE (Preliminary Determination of Epicenter)
#                           * IISC (Internation Seismological Centre)
#                           * IREB (Reviewed Event Bulletin)
#                           * IUSGS (US Geological Survey)
#                           * IBRK (UC Berkeley)
#                           * ICALTECH (California Institute of Technology)
#                           * ILLNL (Lawrence Livermore National Laboratory)
#                           * IEVLOC (Event Location (computer program) )
#                           * IJSOP (Joint Seismic Observation Program)
#                           * IUSER (The individual using SAC2000)
#                           * IUNKNOWN (unknown)
#     ievtyp       I    Type of event:
#                           * IUNKN (Unknown)
#                           * INUCL (Nuclear event)
#                           * IPREN (Nuclear pre-shot event)
#                           * IPOSTN (Nuclear post-shot event)
#                           * IQUAKE (Earthquake)
#                           * IPREQ (Foreshock)
#                           * IPOSTQ (Aftershock)
#                           * ICHEM (Chemical explosion)
#                           * IQB (Quarry or mine blast confirmed by quarry)
#                           * IQB1 (Quarry/mine blast with designed shot
#                             info-ripple fired)
#                           * IQB2 (Quarry/mine blast with observed shot
#                             info-ripple fired)
#                           * IQMT (Quarry/mining-induced events:
#                             tremors and rockbursts)
#                           * IEQ (Earthquake)
#                           * IEQ1 (Earthquakes in a swarm or aftershock
#                             sequence)
#                           * IEQ2 (Felt earthquake)
#                           * IME (Marine explosion)
#                           * IEX (Other explosion)
#                           * INU (Nuclear explosion)
#                           * INC (Nuclear cavity collapse)
#                           * IO\_ (Other source of known origin)
#                           * IR (Regional event of unknown origin)
#                           * IT (Teleseismic event of unknown origin)
#                           * IU (Undetermined or conflicting information)
#                           * IOTHER (Other)
#     nevid        N    Event ID (CSS 3.0)
#     norid        N    Origin ID (CSS 3.0)
#     nwfid        N    Waveform ID (CSS 3.0)
#     khole        k    Hole identification if nuclear event.
#     dist         F    Station to event distance (km).
#     az           F    Event to station azimuth (degrees).
#     baz          F    Station to event azimuth (degrees).
#     gcarc        F    Station to event great circle arc length (degrees).
#     lcalda       L    TRUE if DIST AZ BAZ and GCARC are to be calculated from
#                       st event coordinates.
#     iqual        I    Quality of data [not currently used]:
#                           * IGOOD (Good data)
#                           * IGLCH (Glitches)
#                           * IDROP (Dropouts)
#                           * ILOWSN (Low signal to noise ratio)
#                           * IOTHER (Other)
#     isynth       I    Synthetic data flag [not currently used]:
#                           * IRLDTA (Real data)
#                           * ????? (Flags for various synthetic seismogram
#                             codes)
#     user{ai n}   F    User defined variable storage area {ai n}=0,9.
#     kuser{ai n}  K    User defined variable storage area {ai n}=0,2.
#     lovrok       L    TRUE if it is okay to overwrite this file on disk.
#     ============ ==== =========================================================
#


#delta
#depmin
#depmax
#scale
#odelta
#b
#e
#o
#a
#internal
#t0
#t1
#t2
#t3
#t4
#t5
#t6
#t7
#t8
#t9
#f
#resp0
#resp1
#resp2
#resp3
#resp4
#resp5
#resp6
#resp7
#resp8
#resp9
#stla
#stlo
#stel
#stdp
#evla
#evlo
#evel
#evdp
#mag
#user0
#user1
#user2
#user3
#user4
#user5
#user6
#user7
#user8
#user9
#dist
#az
#baz
#gcarc
#internal
#internal
#depmen
#cmpaz
#cmpinc
#xminimum
#xmaximum
#yminimum
#ymaximum
#unused
#unused
#unused
#unused
#unused
#unused
#unused
#nzyear
#nzjday
#nzhour
#nzmin
#nzsec
#nzmsec
#nvhdr
#norid
#nevid
#npts
#internal
#nwfid
#nxsize
#nysize
#unused
#iftype
#idep
#iztype
#unused
#iinst
#istreg
#ievreg
#ievtyp
#iqual
#isynth
#imagtyp
#imagsrc
#unused
#unused
#unused
#unused
#unused
#unused
#unused
#unused
#leven
#lpspol
#lovrok
#lcalda
#unused
#kstnm
#kevnm
#khole
#ko
#ka
#kt0
#kt1
#kt2
#kt3
#kt4
#kt5
#kt6
#kt7
#kt8
#kt9
#kf
#kuser0
#kuser1
#kuser2
#kcmpnm
#knetwk
#kdatrd
#kinst
