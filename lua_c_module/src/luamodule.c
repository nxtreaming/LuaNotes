#include "luamodule.h"
#include <lauxlib.h>
#include <lualib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define module functions

// Function: add two numbers
static int module_add(lua_State *L) {
    // Get arguments from Lua stack
    double a = luaL_checknumber(L, 1);
    double b = luaL_checknumber(L, 2);
    
    // Perform calculation
    double result = a + b;
    
    // Push result to Lua stack
    lua_pushnumber(L, result);
    
    // Return number of results
    return 1;
}

// Function: multiply two numbers
static int module_multiply(lua_State *L) {
    // Get arguments from Lua stack
    double a = luaL_checknumber(L, 1);
    double b = luaL_checknumber(L, 2);
    
    // Perform calculation
    double result = a * b;
    
    // Push result to Lua stack
    lua_pushnumber(L, result);
    
    // Return number of results
    return 1;
}

// Function: say hello
static int module_hello(lua_State *L) {
    // Get string argument
    const char *name = luaL_checkstring(L, 1);
    
    // Create greeting message
    char message[100];
    snprintf(message, sizeof(message), "Hello, %s from C module!", name);
    
    // Push result to Lua stack
    lua_pushstring(L, message);
    
    // Return number of results
    return 1;
}

// Function: get module version
static int module_version(lua_State *L) {
    lua_pushstring(L, "MyLuaModule 1.0.0");
    return 1;
}

// Define all functions in the module
static const struct luaL_Reg module_functions[] = {
    {"add", module_add},
    {"hello", module_hello},
    {"version", module_version},
    {"multiply", module_multiply},
    {NULL, NULL}  // End of array marker
};

// Module entry point
// This function name is important: luaopen_[modulename]
// It must match the module name that Lua will use to require it
MODULE_API int luaopen_myluamodule(lua_State *L) {
    // Create a new table for the module
    luaL_newlib(L, module_functions);
    
    return 1;  // Return the module table
}
