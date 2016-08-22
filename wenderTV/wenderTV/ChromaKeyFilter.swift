/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import CoreImage

func createColorCube(_ size: Int, transparentHue: Float, transparentDeviation: Float) -> [RGB] {
  var cube = [RGB]()
  let minHue = transparentHue * (1.0 - transparentDeviation)
  let maxHue = transparentHue * (1.0 + transparentDeviation)
  
  for blue in 0..<size {
    for green in 0..<size {
      for red in 0..<size {
        let sz = Float(size - 1)
        var rgb: RGB = (red: Float(red) / sz, green: Float(green) / sz, blue: Float(blue) / sz, 1.0)
        let hsv = rgb2hsv(rgb)
        if hsv.brightness > 0.1 {
          rgb.alpha  = (hsv.hue > minHue) && (hsv.hue < maxHue) ? 0.0 : 1.0
          rgb.red   *= rgb.alpha
          rgb.green *= rgb.alpha
          rgb.blue  *= rgb.alpha
        }
        cube.append(rgb)
      }
    }
  }
  
  return cube
}

func convertCubeToCubeData(_ cube: [RGB]) -> Data {
  return Data(bytes: UnsafeRawPointer(cube), count: cube.count * MemoryLayout<RGB>.size)
}

func createChromaKeyFilter(_ hue: Float, variance: Float = 0.3, size: Int = 64) -> CIFilter? {
  let cube = createColorCube(size, transparentHue: hue, transparentDeviation: variance)
  let cubeData = convertCubeToCubeData(cube)
  
  let filter = CIFilter(name: "CIColorCube")
  filter?.setValue(size, forKey: "inputCubeDimension")
  filter?.setValue(cubeData, forKey: "inputCubeData")
  
  return filter
}
