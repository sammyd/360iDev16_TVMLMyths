//The MIT License (MIT)
//
//Copyright (c) 2015 Johan Kasperi
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import UIKit

// Typealias for RGB color values
typealias RGB = (red: Float, green: Float, blue: Float, alpha: Float)

// Typealias for HSV color values
typealias HSV = (hue: Float, saturation: Float, brightness: Float, alpha: Float)

func hsv2rgb(_ hsv: HSV) -> RGB {
  // Converts HSV to a RGB color
  var rgb: RGB = (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
  var r: Float
  var g: Float
  var b: Float
  
  let i = Int(hsv.hue * 6)
  let f = hsv.hue * 6 - Float(i)
  let p = hsv.brightness * (1 - hsv.saturation)
  let q = hsv.brightness * (1 - f * hsv.saturation)
  let t = hsv.brightness * (1 - (1 - f) * hsv.saturation)
  switch (i % 6) {
  case 0: r = hsv.brightness; g = t; b = p; break;
    
  case 1: r = q; g = hsv.brightness; b = p; break;
    
  case 2: r = p; g = hsv.brightness; b = t; break;
    
  case 3: r = p; g = q; b = hsv.brightness; break;
    
  case 4: r = t; g = p; b = hsv.brightness; break;
    
  case 5: r = hsv.brightness; g = p; b = q; break;
    
  default: r = hsv.brightness; g = t; b = p;
  }
  
  rgb.red = r
  rgb.green = g
  rgb.blue = b
  rgb.alpha = hsv.alpha
  return rgb
}

func rgb2hsv(_ rgb: RGB) -> HSV {
  // Converts RGB to a HSV color
  var hsb: HSV = (hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.0)
  
  let rd: Float = rgb.red
  let gd: Float = rgb.green
  let bd: Float = rgb.blue
  
  let maxV: Float = max(rd, max(gd, bd))
  let minV: Float = min(rd, min(gd, bd))
  var h: Float = 0
  var s: Float = 0
  let b: Float = maxV
  
  let d: Float = maxV - minV
  
  s = maxV == 0 ? 0 : d / minV;
  
  if (maxV == minV) {
    h = 0
  } else {
    if (maxV == rd) {
      h = (gd - bd) / d + (gd < bd ? 6 : 0)
    } else if (maxV == gd) {
      h = (bd - rd) / d + 2
    } else if (maxV == bd) {
      h = (rd - gd) / d + 4
    }
    
    h /= 6;
  }
  
  hsb.hue = h
  hsb.saturation = s
  hsb.brightness = b
  hsb.alpha = rgb.alpha
  return hsb
}

