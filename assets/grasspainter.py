import sys
from PIL import Image, ImageDraw
import random
from coloraide import Color


def to_rgba(c: Color):
    rgb = c.convert("srgb")
    r, g, b = [round(max(0, min(1, v)) * 255) for v in rgb.coords()]
    return (r, g, b, 255)


im = Image.new("RGBA", size=(1280, 1280))

draw = ImageDraw.Draw(im)

color_palette = Color.steps(
    ["hsl(114, 50%, 34%)", "hsl(114, 50%, 40%)"], steps=8, space="hsl"
)

thickness = 4
mu = 12
sigma = 5

for column in range(0, im.size[0], thickness):
    start = 0
    while start < im.size[1]:
        l = max(random.gauss(mu=8, sigma=4), 1)
        end = min(int(start + l), im.size[1] - 1)
        color = to_rgba(random.choice(color_palette))
        draw.rectangle([(column, start), (column + thickness - 1, end)], fill=color)
        start = end + 1

# write to stdout
with open("grass.png", "wb") as f:
    im.save(f, format="PNG")
