cmake_policy(PUSH)
cmake_policy(VERSION 3.18)

function(assert condition)
    message(CHECK_START "${condition}")
    cmake_language(EVAL
        CODE "
            if(NOT (${condition}))
                message(FATAL_ERROR [=[Failed assertion: ${condition}]=])
            endif()
        "
    )
    message(CHECK_PASS "Pass")
endfunction()

cmake_policy(POP)
