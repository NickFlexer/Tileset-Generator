---
-- main.lua


package.path = package.path .. ";lib/?/init.lua;lib/?.lua;src/?.lua"


local argparse = require "argparse"


local img
local tile_width, tile_height
local quads = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {}
}


function love.load(arg)
    local parser = argparse("script", "An example.")
    parser:argument("input", "Input image file.")
    local args = parser:parse(arg)

    assert(love.filesystem.getInfo(args.input), "File " .. args.input .. " does not exist!")
    img = love.graphics.newImage(args.input)

    tile_width = img:getWidth() / 4
    tile_height = img:getHeight() / 6

    quads[1][1] = get_quad(3, 1)
    quads[1][2] = get_quad(1, 3)
    quads[1][3] = get_quad(3, 5)
    quads[1][4] = get_quad(3, 3)
    quads[1][5] = get_quad(1, 5)

    quads[2][1] = get_quad(4, 1)
    quads[2][2] = get_quad(4, 3)
    quads[2][3] = get_quad(2, 5)
    quads[2][4] = get_quad(2, 3)
    quads[2][5] = get_quad(4, 5)

    quads[3][1] = get_quad(3, 2)
    quads[3][2] = get_quad(1, 6)
    quads[3][3] = get_quad(3, 4)
    quads[3][4] = get_quad(3, 6)
    quads[3][5] = get_quad(1, 4)

    quads[4][1] = get_quad(4, 2)
    quads[4][2] = get_quad(4, 6)
    quads[4][3] = get_quad(2, 4)
    quads[4][4] = get_quad(2, 6)
    quads[4][5] = get_quad(4, 4)
end


function love.update(dt)

end


function love.draw()
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

    for i, data in ipairs(tiles) do
        print_some_tile(data, i - ((math.ceil(i / 8) - 1) * 8), math.ceil(i / 8))
    end
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
