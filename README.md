# Tileset-Generator
Generate a complete tileset from a compressed one

It uses [LÖVE](https://love2d.org/) for image manipulation
Tileset-Generator convert tileset like this:

![compreseg](https://github.com/NickFlexer/Tileset-Generator/blob/master/input_img.png?raw=true)

To tileset like this:

![complete](https://github.com/NickFlexer/Tileset-Generator/blob/master/output_img.png?raw=true)

## How to use
* put simple tileset image (for example input_img.png) to source folder
* run
```love . input_img.png ounput_img.png```
* grab complite tileset (for example ounput_img.png) from LÖVE [write directory](https://love2d.org/wiki/love.filesystem) 
* enjoy


## Dependencies

* [argparse](https://github.com/mpeterv/argparse)
* [middleclass](https://github.com/kikito/middleclass)
