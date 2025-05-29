#!/bin/bash
echo "Building Lua C Module..."

# Create a clean build directory
rm -rf build
mkdir -p build
cd build

# Run CMake with the current directory as the source
cmake ..
cmake --build .

echo ""
echo "Build completed!"
echo ""
echo "Testing module..."
echo ""

lua test_module.lua
