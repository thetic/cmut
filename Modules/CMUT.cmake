cmake_policy(PUSH)
cmake_policy(VERSION 3.18)

function(add_cmut_test_project)
    # Parse arguments
    set(options)
    set(oneValueArgs NAME SOURCE_DIR)
    set(multiValueArgs CMAKE_FLAGS)
    cmake_parse_arguments(
        PARSE_ARGV 0
        CMUT
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
    )

    # Validate arguments
    if(CMUT_UMPARSED_ARGUMENTS)
        string(JOIN "\n\t" split CMUT_UMPARSED_ARGUMENTS)
        message(FATAL_ERROR
            "add_cmut_test_project given unknown argument:\n\n\t${split}"
        )
    elseif(NOT CMUT_NAME)
        message(FATAL_ERROR "add_cmut_test_project must be given non-empty NAME.")
    elseif(NOT CMUT_SOURCE_DIR)
        message(FATAL_ERROR "add_cmut_test_project must be given non-empty SOURCE_DIR.")
    endif()

    # Set source directory
    get_filename_component(source_dir
        ${CMUT_SOURCE_DIR} ABSOLUTE
        BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    )
    if(NOT EXISTS "${source_dir}")
        message(FATAL_ERROR
            "The source directory \"${CMUT_SOURCE_DIR}\" does not exist."
        )
    elseif(NOT EXISTS "${source_dir}/CMakeLists.txt")
        message(FATAL_ERROR
            "The source directory \"${CMUT_SOURCE_DIR}\" does not contain a CMakeLists.txt file."
        )
    endif()


    # Injected assertion support
    set(assert_script "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/CMUT/assert.cmake")

    # Set binary directory
    set(binary_dir "${CMAKE_CURRENT_BINARY_DIR}/cmut/${CMUT_NAME}")

    # Delete the binary directory before running.
    add_test(
        NAME ${CMUT_NAME}.cleanup
        COMMAND ${CMAKE_COMMAND} -E rm -rf "${binary_dir}"
    )
    set_tests_properties(${CMUT_NAME}.cleanup PROPERTIES
        FIXTURES_CLEANUP ${CMUT_NAME}.cleanup
    )

    add_test(
        NAME ${CMUT_NAME}
        COMMAND
            ${CMAKE_COMMAND}
            -S "${source_dir}"
            -B "${binary_dir}"
            -D "CMAKE_PROJECT_INCLUDE_BEFORE=${assert_script}"
            ${CMUT_CMAKE_FLAGS}
    )

    set_tests_properties(${CMUT_NAME} PROPERTIES
        FIXTURES_REQUIRED ${CMUT_NAME}.cleanup
    )
endfunction()

cmake_policy(POP)
