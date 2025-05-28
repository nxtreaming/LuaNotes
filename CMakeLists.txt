cmake_minimum_required(VERSION 3.10)
project(CLuaDemo C)

# Setup the Lua directory
set(LUA_DIR "D:/lua-5.4.7")
set(LUA_INCLUDE_DIR "${LUA_DIR}/include")
set(LUA_LIBRARY_DIR "${LUA_DIR}/lib")
set(LUA_BIN_DIR "${LUA_DIR}/bin")

# Add Lua include directory
include_directories(${LUA_INCLUDE_DIR})

# Add Lua library directory
link_directories(${LUA_LIBRARY_DIR})

# Create executable
add_executable(clua_demo main.c)

# Link Lua library
target_link_libraries(clua_demo lua54)

# Copy Lua DLL to output directory (Windows-specific)
if(WIN32)
    add_custom_command(TARGET clua_demo POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${LUA_BIN_DIR}/lua54.dll"
        $<TARGET_FILE_DIR:clua_demo>
    )
endif()

# Copy script.lua to output directory
add_custom_command(TARGET clua_demo POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${CMAKE_SOURCE_DIR}/script.lua"
    $<TARGET_FILE_DIR:clua_demo>
)
