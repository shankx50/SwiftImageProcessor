//: Playground - noun: a place where people can play
import UIKit

let image = UIImage(named: "sample")!

class imageProcessor{
    
    var filterList = [Filter]()
    
    func brigthness(pixel: Pixel) -> Double{
        // https://en.wikipedia.org/wiki/Relative_luminance
        let result = 0.2126 * (Double)(pixel.red) + 0.7152 * (Double)(pixel.green) + 0.07225 * (Double)(pixel.blue)
        
        return result
    }
    
    func appyFilters(filters: [Filter], image: UIImage) -> UIImage{
        
        var totalBrightness: Double = 0
        
                let rgbaImage = RGBAImage(image: image)!
                    for y in 0..<rgbaImage.height{
                        for x in 0..<rgbaImage.width{
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
        
                            for filter in filters{
                                for value in 0...4 {
                                    if(filter.rgba[value] != 0 ){
        
                                        switch value{
        
                                            case 0:
        
                                            pixel.red = filter.rgba[value]
                                            rgbaImage.pixels[index] = pixel
        
                                            case 1:
        
                                            pixel.green = filter.rgba[value]
                                            rgbaImage.pixels[index] = pixel
        
                                            case 2:
        
                                            pixel.blue = filter.rgba[value]
                                            rgbaImage.pixels[index] = pixel
        
                                            case 3:
        
                                            pixel.alpha = filter.rgba[value]
                                            rgbaImage.pixels[index] = pixel
                                            
                                            case 4:
                                            // Relative luminance according to https://en.wikipedia.org/wiki/Relative_luminance
                                            let red = pixel.red
                                            let green = pixel.green
                                            let blue = pixel.blue
                                            
                                            let luminanceModifier = Double(filter.rgba[value])
                                            
                                            let relativeLuminance = Double(red) * 0.2126 + Double(green) * 0.7152 + Double(blue) * 0.0722
                                            
                                            let transformerRed = (relativeLuminance - Double(green) * 0.7152 - Double(blue) * 0.0722) / 0.2126
                                            
                                            let transformerGreen = (relativeLuminance - Double(red) * 0.2126 - Double(blue) * 0.0722 ) / 0.7152
                                            
                                            let transformerBlue = (relativeLuminance - Double(red) * 0.2126 - Double(green) * 0.7152 ) / 0.0722
                                            
                                            pixel.red = UInt8(transformerRed * luminanceModifier / 100 )
                                            pixel.green = UInt8(transformerGreen * luminanceModifier / 100)
                                            pixel.blue =  UInt8(transformerBlue * luminanceModifier / 100)
                                            
                                            rgbaImage.pixels[index] = pixel
                                            
                                            default:
        
                                            print("Nothing to change")
        
                                        }
                                    }
                                }
                            }
                        }
                    }
                let newImage = rgbaImage.toUIImage()!
        return newImage
    }
}

class Filter{
    var rgba = [UInt8](count:5, repeatedValue: 0)
}

let redFilter: Filter = Filter()
redFilter.rgba[0] = 50

let greenFilter: Filter = Filter()
greenFilter.rgba[1] = 45

let blueFilter: Filter = Filter()
blueFilter.rgba[2] = 75

let alphaFilter: Filter = Filter()
alphaFilter.rgba[3] = 50

// Set Luminance Modidier in desired percentage (%), should be <100 to avoid explosion due to internal rounding
let luminanceModifier = Filter()
luminanceModifier.rgba[4] = 95


var processor: imageProcessor = imageProcessor()

// The sequence of filters appended is also the sequence in which the filters will be applied
processor.filterList.append(redFilter)
//processor.filterList.append(alphaFilter)
processor.filterList.append(luminanceModifier)



var result = processor.appyFilters(processor.filterList, image: image)
