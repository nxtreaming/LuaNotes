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

// Define a C function for Lua to call
// All C functions callable from Lua must follow this signature: int func(lua_State *L)
static int c_add(lua_State *L) {
    // Get arguments (from Lua stack)
    double a = luaL_checknumber(L, 1);  // First argument
    double b = luaL_checknumber(L, 2);  // Second argument
    
    // Perform calculation
    double result = a + b;
    
    // Push result onto Lua stack (as return value)
    lua_pushnumber(L, result);
    
    // Number of return values
    return 1;  // We're returning one value
}

// Define another example C function
static int c_hello(lua_State *L) {
    const char *name = luaL_checkstring(L, 1);  // Get string argument
    printf("Hello, %s from C function!\n", name);
    return 0;  // No return values
}

// Define a function list for the module
static const struct luaL_Reg mylib[] = {
    {"add", c_add},
    {"hello", c_hello},
    {NULL, NULL}  // End of list marker
};

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

    // Register C functions to Lua
    lua_pushcfunction(L, c_add);
    lua_setglobal(L, "c_add");  // Function name in Lua is "c_add"

    lua_pushcfunction(L, c_hello);
    lua_setglobal(L, "c_hello");  // Function name in Lua is "c_hello"

    // Create a new module
    luaL_newlib(L, mylib);
    lua_setglobal(L, "mylib");  // Module name is "mylib"

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

    // Example 4: Calling C functions from Lua
    printf("Example 4: Calling C functions from Lua\n");
    const char *lua_code_call_c = 
        "print('Calling C function from Lua:')\n"
        "local result = c_add(10, 40)\n"
        "print('Result of c_add(10, 40) =', result)\n"
        "c_hello('Lua user')\n";

    status = luaL_dostring(L, lua_code_call_c);
    handle_error(L, status);
    printf("\n");

    // Example 5: Using C module from Lua
    printf("Example 5: Using C module from Lua\n");
    const char *lua_code_module = 
        "print('Using C module from Lua:')\n"
        "local result = mylib.add(30, 40)\n"
        "print('Result of mylib.add(30, 40) =', result)\n"
        "mylib.hello('Module user')\n";

    status = luaL_dostring(L, lua_code_module);
    handle_error(L, status);
    printf("\n");
    
    // Close Lua state
    lua_close(L);
    
    printf("Demo completed successfully!\n");
    return 0;
}


