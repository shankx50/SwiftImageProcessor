import UIKit

let image = UIImage(named: "sample")!

// The Filter class contains the definition of a simple RGBA variable
class Filter{
    var rgba = [UInt8](count:5, repeatedValue: 0)
}

// Here are the 5 filters that can later be selected. By modifying the RGBA values, I intened to serve the requirement to create modifiers to individual filters.
let redFilter: Filter = Filter()
redFilter.rgba[0] = 255

let greenFilter: Filter = Filter()
greenFilter.rgba[1] = 45

let blueFilter: Filter = Filter()
blueFilter.rgba[2] = 255

let alphaFilter: Filter = Filter()
alphaFilter.rgba[3] = 50

// Set Luminance Modidier in desired percentage (%), should be <100 to avoid explosion due to internal rounding
let luminanceModifier = Filter()
luminanceModifier.rgba[4] = 65



class ImageProcessor{
    
    var filterSequenceList: [String] = []
    
    //This Dictionary is later used to accept strings to set the filter the processor will apply.
    
    var filtersAvailable: [String: Filter] = [
        "redFilter": redFilter,
        "greenFilter": greenFilter,
        "blueFilter": blueFilter,
        "alphaFilter": alphaFilter,
        "luminanceModifier": luminanceModifier
    ]
    
    func addFilterToSequence(filterName: String){
        filterSequenceList.append(filterName)
    }
    
    func appyFilters(image: UIImage) -> UIImage{
        
        var filters: [Filter] = []
        
        // A list if filters gets populated according to the array of strings entered.
        for name in filterSequenceList{
            filters.append(filtersAvailable[name]!)
        }
        
                let rgbaImage = RGBAImage(image: image)!
        
        // Loop through each pixel
                    for y in 0..<rgbaImage.height{
                        for x in 0..<rgbaImage.width{
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
        // Loop through each filter
                            for filter in filters{
                                for value in 0...4 {
                                    
                                    // RGBA values with value 0 get ignored. This means that 1 needs to be used if you wand that specific value to be very low.
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
                                            // Relative luminance according to https://en.wikipedia.org/wiki/Relative_luminance. The entire luminance filter algorithm happens here.
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

//--------------------------------------- Start using the class here--------------------------------


var processor: ImageProcessor = ImageProcessor()

// Use the addFilterToSequence function and pass in one of the strings mentioned below. Using a non-existing filter name will cause a runtime error
// "redFilter"
// "greenFilter"
// "blueFilter"
// "alphaFilter"
// "luminanceModifier"

processor.addFilterToSequence("redFilter")
processor.addFilterToSequence("blueFilter")
processor.addFilterToSequence("luminanceModifier")

processor.filterSequenceList

processor.appyFilters(image)

