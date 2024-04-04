cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

# ---------------
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

# Project setup, versioning stuff here, change when changing the version
# ~~~
# Note: keep the project name lower case only for easy linux packaging support
# ~~~
project(TestMessage VERSION 0.2)

set(TEST_COMPONENTS "")
set(TEST_COMPONENTS ${TEST_COMPONENTS} "Test1")
set(TEST_COMPONENTS ${TEST_COMPONENTS} "Test1")


list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR})
include(MessageHelpers)

# or
# include(${CMAKE_SOURCE_DIR}/MessageHelpers.cmake)

message( "normal message")
message(STATUS "status message")
message(WARNING "warning message")

message_prefix_push("prefix1")
message( "normal message")
message(STATUS "status message")
message(WARNING "warning message ignores prefix")

message_prefix_push("prefix2")
message( "normal message")
message(STATUS "status message")

message_prefix_pop()
message( "normal message")
message(STATUS "status message")

message_prefix_clear()
# get changeset id
find_package(Git QUIET)

if(GIT_FOUND AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.git")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse HEAD WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_CHANGESET
    )
    if(GIT_CHANGESET)
        # remove new line sometime appearing in git changeset
        string(REGEX REPLACE "\n$" "" GIT_CHANGESET "${GIT_CHANGESET}")
    endif()
else()
    set(GIT_CHANGESET "")
endif()



option(TEST_GENERATE_LIB "Do generate lib ?" ON)

# Wrap up of settings printed on build
message(NOTICE "")
message_title(" Final overview for ${PROJECT_NAME} ")
message_info(" ")
message_info(
    "Version:               ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH} @ ${VERSION_HOST}"
)
message_info("Git Changeset: ${GIT_CHANGESET}")
message_info(" ")
message_info("Install prefix: ")
message_info("  ${CMAKE_INSTALL_PREFIX}")
message_info(" ")
message_info(
    "Compiler: ${CMAKE_CXX_COMPILER} - ${CMAKE_CXX_COMPILER_ID} in version ${CMAKE_CXX_COMPILER_VERSION}."
)
message_setting("CMAKE_BUILD_TYPE")
message_info("  possible options: Debug Release RelWithDebInfo MinSizeRel")
message_info("  set with ` cmake -DCMAKE_BUILD_TYPE=Debug .. `")
message_info(" ")
message_info("print setting ")
message_setting("TEST_GENERATE_LIB")
message_info(" ")
message_info("print option with help ")
message_option("TEST_GENERATE_LIB")
message_info(" ")
string(REPLACE ";" " " COMPONENTS_LIST "${TEST_COMPONENTS}")
message_info(" -- Configured components: ${COMPONENTS_LIST}")

message_end()
message(NOTICE "")

