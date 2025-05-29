#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#ifdef _WIN32
#include <windows.h>
#else
#include <unistd.h>
#include <limits.h>
#endif

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

    // Print current working directory
    printf("Current working directory: ");
    #ifdef _WIN32
    {
        char buffer[MAX_PATH];
        GetCurrentDirectory(MAX_PATH, buffer);
        printf("%s\n", buffer);
    }
    #else
    {
        char buffer[PATH_MAX];
        getcwd(buffer, PATH_MAX);
        printf("%s\n", buffer);
    }
    #endif
    printf("\n");

    // Example 3: Load Lua script from file
    printf("Example 3: Loading Lua script from file\n");

    // Try to load script.lua from different possible locations
    int script_found = 0;
    const char* script_paths[] = {
        "script.lua",                     // Current directory
        "../script.lua",                  // Parent directory
        "../../script.lua",              // Parent of parent directory
        NULL                             // End marker
    };

    for (int i = 0; script_paths[i] != NULL; i++) {
        printf("Trying to load: %s\n", script_paths[i]);
        status = luaL_loadfile(L, script_paths[i]);
        if (status == LUA_OK) {
            printf("Found script at: %s\n", script_paths[i]);
            script_found = 1;
            // Execute the loaded script
            status = lua_pcall(L, 0, LUA_MULTRET, 0);
            handle_error(L, status);
            break;
        }
    }

    if (!script_found) {
        printf("Note: script.lua not found in any of the searched locations.\n");
        printf("Please create script.lua in one of these directories.\n");
    }
    printf("\n");

    // Close Lua state
    lua_close(L);
    
    printf("Demo completed successfully!\n");
    return 0;
}
