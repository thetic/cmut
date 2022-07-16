include(CMUT)

add_cmut_test_project(
    NAME CMUT.passing_asserts
    SOURCE_DIR passing_asserts
)

add_cmut_test_project(
    NAME CMUT.failing_asserts
    SOURCE_DIR failing_asserts
)

set_tests_properties(CMUT.failing_asserts PROPERTIES
    PASS_REGULAR_EXPRESSION "Failed assertion"
)
