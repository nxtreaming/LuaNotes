#ifndef LUA_MODULE_H
#define LUA_MODULE_H

#include <lua.h>

// Define export macro for different platforms
#if defined(_WIN32) || defined(_WIN64)
  #if defined(MODULE_EXPORTS)
    #define MODULE_API __declspec(dllexport)
  #else
    #define MODULE_API __declspec(dllimport)
  #endif
#else
  #define MODULE_API __attribute__((visibility("default")))
#endif

// Module entry point with explicit export
MODULE_API int luaopen_myluamodule(lua_State *L);

#endif // LUA_MODULE_H

