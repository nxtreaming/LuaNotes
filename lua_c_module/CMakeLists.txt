cmake_minimum_required(VERSION 3.10)
project(LuaCModule C)

# Set C standard
set(CMAKE_C_STANDARD 99)

# Build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Lua paths - adjust these to match your Lua installation
set(LUA_DIR "D:/lua-5.4.7")
set(LUA_INCLUDE_DIR "${LUA_DIR}/include")
set(LUA_LIBRARY_DIR "${LUA_DIR}/lib")

# Include directories
include_directories(${LUA_INCLUDE_DIR})
include_directories(${CMAKE_SOURCE_DIR}/src)  # Add this line to include src directory
link_directories(${LUA_LIBRARY_DIR})

# Create shared library
add_library(myluamodule SHARED 
    src/luamodule.c
)

# Add definition for exports
target_compile_definitions(myluamodule PRIVATE MODULE_EXPORTS)

# Set output name with appropriate prefix and extension
if(WIN32)
    set_target_properties(myluamodule PROPERTIES 
        PREFIX ""
        OUTPUT_NAME "myluamodule"
        SUFFIX ".dll"
    )
    
    # Force Windows to use __declspec(dllexport)
    if(MSVC)
        set_target_properties(myluamodule PROPERTIES 
            WINDOWS_EXPORT_ALL_SYMBOLS TRUE
        )
    endif()
else()
    set_target_properties(myluamodule PROPERTIES 
        PREFIX ""
        OUTPUT_NAME "myluamodule"
        SUFFIX ".so"
    )
endif()

# Link against Lua library
if(WIN32)
    target_link_libraries(myluamodule lua54)
else()
    target_link_libraries(myluamodule lua)
endif()

# Add module definition file for explicit exports
if(MSVC)
    set_target_properties(myluamodule PROPERTIES 
        LINK_FLAGS "/DEF:${CMAKE_SOURCE_DIR}/src/myluamodule.def"
    )
endif()

# Copy Lua DLL to output directory (Windows-specific)
if(WIN32)
    add_custom_command(TARGET myluamodule POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${LUA_DIR}/bin/lua54.dll"
        "$<TARGET_FILE_DIR:myluamodule>/lua54.dll"
    )
endif()

# Copy test script to build directory
if(WIN32)
    # For multi-configuration generators (like Visual Studio)
    add_custom_command(TARGET myluamodule POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_SOURCE_DIR}/test/test_module.lua"
        "$<TARGET_FILE_DIR:myluamodule>/test_module.lua"
    )
else()
    # For single-configuration generators
    configure_file(${CMAKE_SOURCE_DIR}/test/test_module.lua ${CMAKE_BINARY_DIR}/test_module.lua COPYONLY)
endif()

# Create a simple module info file to verify DLL is working
if(WIN32)
    add_custom_command(TARGET myluamodule POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "-- Check if module exports are working" > "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "local ffi = require('ffi')" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "ffi.cdef[[" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "void* LoadLibraryA(const char* lpFileName);" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "void* GetProcAddress(void* hModule, const char* lpProcName);" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "]]" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "local handle = ffi.C.LoadLibraryA('./myluamodule.dll')" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "if handle then" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "  print('DLL loaded successfully')" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "  local func = ffi.C.GetProcAddress(handle, 'luaopen_myluamodule')" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "  if func then" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "    print('Function luaopen_myluamodule found')" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "  else" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "    print('Function luaopen_myluamodule NOT found')" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "  end" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "else" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "  print('Failed to load DLL')" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
        COMMAND ${CMAKE_COMMAND} -E echo "end" >> "$<TARGET_FILE_DIR:myluamodule>/check_exports.lua"
    )
endif()

# Print information
message(STATUS "Lua include directory: ${LUA_INCLUDE_DIR}")
message(STATUS "Lua library directory: ${LUA_LIBRARY_DIR}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")






