# SwiftImageProcessor

This is the assignment InstaFilter Processor which I am completing for the Coursera course Introduction to Swift Programming by the University of Toronto.

##Step 1: Simple filter

In the first step, all I do is loop trough all the pixels and set the blue value to its maximum.

```
for y in 0..<rgbaImage.height{
    for x in 0..<rgbaImage.width{
        let index = y * rgbaImage.width + x
        var pixel = rgbaImage.pixels[index]
        pixel.blue = 255
        rgbaImage.pixels[index] = pixel

    }
}
```