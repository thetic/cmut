cmake_minimum_required(VERSION 3.18)

project(cmut
    VERSION 0.0.1
    DESCRIPTION "CMake Unit Test framework"
    HOMEPAGE_URL "https://github.com/thetic/cmut"
    LANGUAGES NONE
)

include(CTest)

if(CMAKE_VERSION GREATER_EQUAL "3.21")
    # PROJECT_IS_TOP_LEVEL is built in.
elseif(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    set(PROJECT_IS_TOP_LEVEL TRUE)
else()
    set(PROJECT_IS_TOP_LEVEL FALSE)
endif()

# Build tests by default unless used as a subproject.
include(CMakeDependentOption)
cmake_dependent_option(
    CMUT_BUILD_TESTING "Build CMUT self tests"
    ${PROJECT_IS_TOP_LEVEL} "BUILD_TESTING" OFF
)

# Add modules to path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Modules")
if(NOT PROJECT_IS_TOP_LEVEL)
    set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
endif()

if(CMUT_BUILD_TESTING)
    add_subdirectory(Tests)
endif()
