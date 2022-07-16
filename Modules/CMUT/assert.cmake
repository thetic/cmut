include_guard(GLOBAL)
cmake_policy(PUSH)
cmake_policy(VERSION 3.18)

function(assert condition)
    message(CHECK_START "${condition}")
    cmake_language(EVAL
        CODE "
            if((${condition}))
                message(CHECK_PASS [=[Pass]=])
            else()
                message(SEND_ERROR [=[Failed assertion: ${condition}]=])
            endif()
        "
    )
endfunction()

cmake_policy(POP)
