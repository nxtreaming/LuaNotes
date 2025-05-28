#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

// Simple error handling function
void handle_error(lua_State *L, int status) {
    if (status != LUA_OK) {
        fprintf(stderr, "Lua error: %s\n", lua_tostring(L, -1));
        lua_pop(L, 1); // Remove error message
    }
}

int main() {
    printf("C Lua Demo - Calling Lua from C\n");
    printf("================================\n\n");

    // Create Lua state
    lua_State *L = luaL_newstate();
    if (!L) {
        fprintf(stderr, "Error creating Lua state\n");
        return 1;
    }

    // Load Lua standard libraries
    luaL_openlibs(L);

    // Example 1: Execute simple Lua code
    printf("Example 1: Running Lua code directly\n");
    int status = luaL_dostring(L, "print('Hello from Lua!')");
    handle_error(L, status);
    printf("\n");

    // Example 2: Define and call a Lua function
    printf("Example 2: Defining and calling a Lua function\n");
    const char *lua_code = 
        "function add(a, b)\n"
        "    return a + b\n"
        "end";
    
    status = luaL_dostring(L, lua_code);
    handle_error(L, status);
    
    // Call Lua function
    lua_getglobal(L, "add");  // Get function
    lua_pushnumber(L, 5);     // First parameter
    lua_pushnumber(L, 7);     // Second parameter
    
    status = lua_pcall(L, 2, 1, 0);  // Call function with 2 args, 1 return value
    handle_error(L, status);
    
    // Get result
    if (lua_isnumber(L, -1)) {
        double result = lua_tonumber(L, -1);
        printf("Result of add(5, 7) = %.1f\n", result);
    }
    lua_pop(L, 1);  // Pop result
    printf("\n");

    // Example 3: Load Lua script from file
    printf("Example 3: Loading Lua script from file\n");
    printf("(Create a file named 'script.lua' with some Lua code)\n");
    status = luaL_dofile(L, "LuaHello-day-3.lua");
    if (status != LUA_OK) {
        printf("Note: script.lua not found or contains errors. This is expected if you haven't created it yet.\n");
        lua_pop(L, 1);  // Pop error message
    }
    printf("\n");

    // Close Lua state
    lua_close(L);
    
    printf("Demo completed successfully!\n");
    return 0;
}

