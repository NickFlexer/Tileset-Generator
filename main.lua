---
-- main.lua


package.path = package.path .. ";lib/?/init.lua;lib/?.lua;src/?.lua"


local argparse = require "argparse"

local Generator = require "generator"


local generator


function love.load(arg)
    local parser = argparse("love .", "Generate a complete tileset from a compressed one")
    parser:argument("input", "Input image file. Example input_tileset.png")
    parser:argument("output", "Output image file. Example output_tileset.png")
    local args = parser:parse(arg)

    assert(love.filesystem.getInfo(args.input), "File " .. args.input .. " does not exist!")

    generator = Generator({
        input_file_name = args.input,
        output_file_name = args.output
    })
end


function love.update(dt)
    if generator:is_drawed() then
        generator:save_file()
        love.event.quit()
    end
end


function love.draw()
    generator:draw()
end
