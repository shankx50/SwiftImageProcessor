//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!

let rgbaImage = RGBAImage(image: image)!

// First Filter - a world in blue

for y in 0..<rgbaImage.height{
    for x in 0..<rgbaImage.width{
        let index = y * rgbaImage.width + x
        var pixel = rgbaImage.pixels[index]
        pixel.blue = 255
        rgbaImage.pixels[index] = pixel

    }
}

let newImage = rgbaImage.toUIImage()!
