module Harness

load("test")
using Test

export runTest, @test

function runTest(testfunc, testname)
    println(testname)
    testfunc()
end
end # module