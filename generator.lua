---
-- generator.lua


local class = require "middleclass"


local Generator = class("Generator")

function Generator:initialize(data)
    self.input_file_name = data.input_file_name
    self.output_file_name = data.output_file_name

    self.img = love.graphics.newImage(self.input_file_name)
    self.tile_width = self.img:getWidth() / 4
    self.tile_height = self.img:getHeight() / 6

    self.drawed = false

    self.quads = {
        [1] = {
            [2] = self:_get_quad(1, 3),
            [1] = self:_get_quad(3, 1),
            [3] = self:_get_quad(3, 5),
            [4] = self:_get_quad(3, 3),
            [5] = self:_get_quad(1, 5)
        },
        [2] = {
            [1] = self:_get_quad(4, 1),
            [2] = self:_get_quad(4, 3),
            [3] = self:_get_quad(2, 5),
            [4] = self:_get_quad(2, 3),
            [5] = self:_get_quad(4, 5)
        },
        [3] = {
            [1] = self:_get_quad(3, 2),
            [2] = self:_get_quad(1, 6),
            [3] = self:_get_quad(3, 4),
            [4] = self:_get_quad(3, 6),
            [5] = self:_get_quad(1, 4)
        },
        [4] = {
            [1] = self:_get_quad(4, 2),
            [2] = self:_get_quad(4, 6),
            [3] = self:_get_quad(2, 4),
            [4] = self:_get_quad(2, 6),
            [5] = self:_get_quad(4, 4)
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

    self.canvas = love.graphics.newCanvas((self.img:getWidth() / 2) * 8, (self.img:getHeight() / 3) * 6 )
    self.canvas:renderTo(
        function ()
            for i, tile in ipairs(tiles) do
                self:_draw_full_tile(tile, i - ((math.ceil(i / 8) - 1) * 8), math.ceil(i / 8))
            end
        end
    )
end

function Generator:draw()
    love.graphics.setColor(1, 1, 1);
    love.graphics.draw(self.canvas);

    self.drawed = true
end

function Generator:is_drawed()
    return self.drawed
end


function Generator:save_file()
    local filedata = self.canvas:newImageData():encode("png")
    love.filesystem.write(self.output_file_name, filedata)
end

function Generator:_get_quad(x, y)
    return love.graphics.newQuad(
        x * self.tile_width - self.tile_width,
        y * self.tile_height - self.tile_height,
        self.tile_width,
        self.tile_height,
        self.img:getWidth(),
        self.img:getHeight()
    )
end

function Generator:_draw_full_tile(data, x, y)
    love.graphics.draw(
        self.img, self.quads[1][data[1]],
        (1 + (x - 1) * 2) * self.tile_width - self.tile_width,
        (1 + (y - 1) * 2) * self.tile_height - self.tile_height
    )

    love.graphics.draw(
        self.img, self.quads[2][data[2]],
        (2 + (x - 1) * 2) * self.tile_width - self.tile_width,
        (1 + (y - 1) * 2) * self.tile_height - self.tile_height
    )

    love.graphics.draw(
        self.img, self.quads[3][data[3]],
        (1 + (x - 1) * 2) * self.tile_width - self.tile_width,
        (2 + (y - 1) * 2) * self.tile_height - self.tile_height
    )

    love.graphics.draw(
        self.img, self.quads[4][data[4]],
        (2 + (x - 1) * 2) * self.tile_width - self.tile_width,
        (2 + (y - 1) * 2) * self.tile_height - self.tile_height
    )
end

return Generator
