include(CMUT)

assert(TRUE)
assert("NOT FALSE")
assert("1 GREATER 0")

set(VARIABLE "something")
assert("VARIABLE")
assert("DEFINED VARIABLE")
assert([=[VARIABLE STREQUAL "something"]=])

unset(VARIABLE)
assert("NOT VARIABLE")
assert("NOT DEFINED VARIABLE")
