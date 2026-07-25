import sys
from PIL import Image, ImageDraw
import random

im = Image.new("RGBA", size=(1280, 1280))

draw = ImageDraw.Draw(im)

color_palette = [
    (0, 100, 0, 255),
    (0, 120, 0, 255),
    (0, 140, 0, 255),
    (0, 160, 0, 255)
]

for column in range(0, im.size[0]):
    start = 0
    while start < im.size[1]:
        l = max(random.gauss(mu=8, sigma=4), 1)
        end = min(int(start + l), im.size[1] - 1)
        color = random.choice(color_palette)
        # print([(column, start), (column, end)], l, color)
        draw.line([(column, start), (column, end)], fill=color)
        start = end + 1

# write to stdout
with open("grass.png", "wb") as f:
    im.save(f, format="PNG")
