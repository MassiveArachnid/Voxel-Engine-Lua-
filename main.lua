







local Modules = {}







--------------------------------------------------------------------------------------------------
-------------------------- Load all the libraries we will use in the game
cpml = require "Libraries/ss3d/cpml"
Reader = require "Libraries/ss3d/reader"
Num2String = require "Libraries/Num2String/Num2String"
Perlin = require "Libraries/Perlin/Perlin"
IQM = require "Libraries/IQM"
Anim9 = require("Libraries/Anim9/anim9")
Profiler = require "Libraries/Profiler/Profiler"
Binser = require "Libraries/Binser/Binser"
LZW = require("Libraries/Lualzw/Lualzw")
Socket = require("socket")

--------------------------------------------------------------------------------------------------
------------ Adds a module to the game. Modules need a load function, and a ManagedFunctions table
local function LoadModule(ModuleName) 

	print("_____________________________________________________________")
	print("Adding New Module <"..ModuleName..">")
	
	----------------- Load the module
	Modules[ModuleName] = require(ModuleName.."/Init"..ModuleName) -- Get the modules data from file
		

	-- Make sure the module has a table holding all its components
	if Modules[ModuleName].Components == nil then 
		error("Module <"..ModuleName.."> needs a Components table for holding all its Components!")
	else
		-- Go through all the components in the module and load them!
		for ComponentName, ComponentValue in pairs(Modules[ModuleName].Components) do

			-- Load the component from file
			Modules[ModuleName].Components[ComponentName] = require(ModuleName.."/Components/"..ComponentName.."/"..ComponentName)
			print("Loaded Component <"..ComponentName.."> in module <"..ModuleName..">")

			-- Store the component in a local table for easy use
			local Component = Modules[ModuleName].Components[ComponentName]

			-- Store the base path to the components files for easy reference later on
			Component.PATH = ModuleName.."/Components/"..ComponentName.."/"

			-- Check through all the components managed functions and load them from file
			for ManagedFunctionName, ManagedFunctionValue in pairs(Component.ManagedFunctions) do
				Component.ManagedFunctions[ManagedFunctionName] = require(ModuleName.."/Components/"..ComponentName.."/Scripts/"..ManagedFunctionName)
				print("Loaded managed function <"..ManagedFunctionName.."> in component <"..ComponentName..">")
			end

			-- Check through all the components threaded scripts and load them from file
			-- CAUTION If the file doesnt exists this will not throw an error! It will only return nil!
			for ThreadedScriptName, ThreadedScriptValue in pairs(Component.ThreadedScripts) do
				Component.ThreadedScripts[ThreadedScriptName] = love.filesystem.read(ModuleName.."/Components/"..ComponentName.."/Threads/"..ThreadedScriptName..".lua")
				print("Loaded threaded script <"..ThreadedScriptName.."> in component <"..ComponentName..">")
			end

			-- Make sure each component has a .Load function
			if Component.Load == nil then
				error("Component <"..ComponentName.."> needs a Load function! ")
			end

			-- Call the components load function
			Component.Load()

		end
	end	
	
	-- Load everything for the modules
	Modules[ModuleName].Load()
	
end






------------------------------------------------------------ Main Game loop --------------------------------------------------------
------------------------------------------------------------ Main Game loop --------------------------------------------------------
------------------------------------------------------------ Main Game loop --------------------------------------------------------
------------------------------------------------------------ Main Game loop --------------------------------------------------------

GLOBALSTATE = "GameState"


function love.load()

	--- Load modules
	LoadModule("GameState")

end



function love.update(dt)

	Modules[GLOBALSTATE].Update(dt)

end


function love.draw()

	Modules[GLOBALSTATE].Draw()

end











------------------------------------------------------------ Main Game loop --------------------------------------------------------
------------------------------------------------------------ Main Game loop --------------------------------------------------------
------------------------------------------------------------ Main Game loop --------------------------------------------------------
------------------------------------------------------------ Main Game loop --------------------------------------------------------

