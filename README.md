# Voxel-Engine-Lua-
This is a voxel engine I built in Lua that uses tables to handle the world data. While it's not blazing fast due to Lua's table limitations, it's got some neat features working:

Chunks store blocks in 3D tables for easy access
Basic lighting system with sunlight that propagates down
Block face culling (doesn't render faces between blocks)
Basic collision detection for player movement
Dynamic chunk loading based on player position
Textures for different block types

The biggest challenge was hitting Lua's performance ceiling with large table operations, especially when:

Generating new chunks
Running lighting calculations
Handling chunk updates near the player

But it works! You can walk around, break blocks, place them, and explore a simple voxel world. The code is pretty straightforward since it's all in Lua - makes it easy to understand how voxel engines tick under the hood.
I learned a lot about 3D graphics and data structures from this project, even if I hit some speed bumps with Lua's performance. It would probably scream if rewritten in C, but as a learning project it served its purpose well!
