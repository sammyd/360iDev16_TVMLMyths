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

import AVFoundation
import CoreImage

private let CubeDimension = 64

func createChromaKeyComposition(_ background: CIImage, asset: AVAsset, hue: Float = 1/3.0) -> AVVideoComposition {
  let cube = createColorCube(CubeDimension, transparentHue: hue, transparentDeviation: 0.3)
  let cubeData = convertCubeToCubeData(cube)
  
  return AVVideoComposition(asset: asset) {
    request in
    let filtered = request.sourceImage.applyingFilter("CIColorCube", withInputParameters: ["inputCubeData" : cubeData, "inputCubeDimension" : CubeDimension]).clampingToExtent()
    let composited = filtered.compositingOverImage(background)
    request.finish(with: composited, context: nil)
  }
}
