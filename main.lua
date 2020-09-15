---
-- main.lua


package.path = package.path .. ";lib/?/init.lua;lib/?.lua;src/?.lua"


local argparse = require "argparse"
local suit = require "suit"


local img
local tile_width, tile_height
local quads = {}
local canvas
local filename = {text = "tileset"}


function love.load(arg)
    local parser = argparse("script", "An example.")
    parser:argument("input", "Input image file.")
    local args = parser:parse(arg)

    assert(love.filesystem.getInfo(args.input), "File " .. args.input .. " does not exist!")
    img = love.graphics.newImage(args.input)

    tile_width = img:getWidth() / 4
    tile_height = img:getHeight() / 6

    quads = {
        [1] = {
            [1] = get_quad(3, 1),
            [2] = get_quad(1, 3),
            [3] = get_quad(3, 5),
            [4] = get_quad(3, 3),
            [5] = get_quad(1, 5)
        },
        [2] = {
            [1] = get_quad(4, 1),
            [2] = get_quad(4, 3),
            [3] = get_quad(2, 5),
            [4] = get_quad(2, 3),
            [5] = get_quad(4, 5)
        },
        [3] = {
            [1] = get_quad(3, 2),
            [2] = get_quad(1, 6),
            [3] = get_quad(3, 4),
            [4] = get_quad(3, 6),
            [5] = get_quad(1, 4)
        },
        [4] = {
            [1] = get_quad(4, 2),
            [2] = get_quad(4, 6),
            [3] = get_quad(2, 4),
            [4] = get_quad(2, 6),
            [5] = get_quad(4, 4)
        }
    }

    local tiles = {
        {3, 3, 3, 3},
        {1, 3, 3, 3},
        {3, 1, 3, 3},
        {1, 1, 3, 3},
        {3, 3, 1, 3},
        {1, 3, 1, 3},
        {3, 1, 1, 3},
        {1, 1, 1, 3},
        {3, 3, 3, 1},
        {1, 3, 3, 1},
        {3, 1, 3, 1},
        {1, 1, 3, 1},
        {3, 3, 1, 1},
        {1, 3, 1, 1},
        {3, 1, 1, 1},
        {1, 1, 1, 1},
        {4, 4, 3, 3},
        {4, 4, 1, 3},
        {4, 4, 3, 1},
        {4, 4, 1, 1},
        {5, 3, 5, 3},
        {5, 1, 5, 3},
        {5, 3, 5, 1},
        {5, 1, 5, 1},
        {3, 5, 3, 5},
        {1, 5, 3, 5},
        {3, 5, 1, 5},
        {1, 5, 1, 5},
        {3, 3, 4, 4},
        {1, 3, 4, 4},
        {3, 1, 4, 4},
        {1, 1, 4, 4},
        {4, 4, 4, 4},
        {5, 5, 5, 5},
        {2, 4, 5, 3},
        {2, 4, 5, 1},
        {4, 2, 3, 5},
        {4, 2, 1, 5},
        {3, 5, 4, 2},
        {1, 5, 4, 2},
        {5, 3, 2, 4},
        {5, 1, 2, 4},
        {2, 2, 5, 5},
        {2, 4, 2, 4},
        {5, 5, 2, 2},
        {4, 2, 4, 2},
        {2, 2, 2, 2}
    }

    canvas = love.graphics.newCanvas((img:getWidth() / 2) * 8, (img:getHeight() / 3) * 6 )
    canvas:renderTo(
        function ()
            for i, data in ipairs(tiles) do
                print_some_tile(data, i - ((math.ceil(i / 8) - 1) * 8), math.ceil(i / 8))
            end
        end
    )

    print(love.filesystem.getWorkingDirectory())
end


function love.update(dt)
    suit.layout:reset(love.graphics.getWidth() - 128, love.graphics.getHeight() - 32 * 2)

    suit.Input(filename, suit.layout:row(128, 32))

    if suit.Button("Save image", suit.layout:row(128, 32)).hit then
        canvas:newImageData():encode("png", filename.text .. ".png")
    end
end


function love.draw()
    love.graphics.setColor(1, 1, 1);
    love.graphics.draw(canvas);

    suit.draw()
end


function love.textedited(text, start, length)
    -- for IME input
    suit.textedited(text, start, length)
end


function love.textinput(t)
	-- forward text input to SUIT
	suit.textinput(t)
end


function love.keypressed(key)
	-- forward keypresses to SUIT
	suit.keypressed(key)
end


function print_some_tile(data, x, y)
    love.graphics.draw(img, quads[1][data[1]], (1 + (x - 1) * 2) * tile_width - tile_width, (1 + (y - 1) * 2) * tile_height - tile_height)
    love.graphics.draw(img, quads[2][data[2]], (2 + (x - 1) * 2) * tile_width - tile_width, (1 + (y - 1) * 2) * tile_height - tile_height)
    love.graphics.draw(img, quads[3][data[3]], (1 + (x - 1) * 2) * tile_width - tile_width, (2 + (y - 1) * 2) * tile_height - tile_height)
    love.graphics.draw(img, quads[4][data[4]], (2 + (x - 1) * 2) * tile_width - tile_width, (2 + (y - 1) * 2) * tile_height - tile_height)
end


function get_quad(x, y)
    return love.graphics.newQuad(
        x * tile_width - tile_width,
        y * tile_height - tile_height,
        tile_width,
        tile_height,
        img:getWidth(),
        img:getHeight()
    )
end
