//: Playground - noun: a place where people can play
import UIKit

let image = UIImage(named: "sample")!

class imageProcessor{
    
    var filterList = [Filter]()
    
    
    func appyFilters(filters: [Filter], image: UIImage) -> UIImage{
        
                let rgbaImage = RGBAImage(image: image)!
                    for y in 0..<rgbaImage.height{
                        for x in 0..<rgbaImage.width{
                            let index = y * rgbaImage.width + x
                            var pixel = rgbaImage.pixels[index]
        
                            for filter in filters{
                                for value in 0...3 {
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
    var rgba = [UInt8](count:4, repeatedValue: 0)
}

let redFilter: Filter = Filter()
redFilter.rgba[0] = 50

let greenFilter: Filter = Filter()
greenFilter.rgba[1] = 45

let blueFilter: Filter = Filter()
blueFilter.rgba[2] = 75

let alphaFilter: Filter = Filter()
alphaFilter.rgba[3] = 50



var processor: imageProcessor = imageProcessor()

processor.filterList.append(redFilter)
processor.filterList.append(alphaFilter)



var result = processor.appyFilters(processor.filterList, image: image)
