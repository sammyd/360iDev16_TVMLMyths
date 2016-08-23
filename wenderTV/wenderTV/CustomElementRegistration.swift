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

import TVMLKit

private let CalendarElementName = "calendar"
private let CalendarTopColorStyleName = "calendar-top-color"
private let CalendarBottomColorStyleName = "calendar-bottom-color"


func registerTVMLExtensions() {
  registerNewCreatorWithInterfaceFactory()
  registerNewTVMLElementWithElementFactory()
  registerNewStylesWithStyleFactory()
}



fileprivate class ExtendedTVInterfaceCreator: NSObject, TVInterfaceCreating {
  
  fileprivate func resourceURL(name resourceName: String) -> URL? {
    return Bundle.main
      .url(forResource: resourceName, withExtension: "png")
  }
  
  fileprivate func makeView(element: TVViewElement, existingView: UIView?) -> UIView? {
    
    // 2:
    guard element.name == CalendarElementName else {
      return .none
    }
    
    // 3:
    let width = Int(element.attributes?["width"] ?? "") ?? 100
    let height = Int(element.attributes?["height"] ?? "") ?? 100
    
    let calendar = CalendarView(frame:
      CGRect(x: 0, y: 0, width: width, height: height))
    
    
    calendar.dateString = element.attributes?["day"]
    calendar.monthString = element.attributes?["month"]
    
    
    if let topColor = element.style?
      .value(propertyName: CalendarTopColorStyleName)
      as? TVColor {
      calendar.topColor = topColor.color
    }
    
    if let bottomColor = element.style?
      .value(propertyName: CalendarBottomColorStyleName)
      as? TVColor {
      calendar.bottomColor = bottomColor.color
    }
    
    return calendar
  }
}

private func registerNewCreatorWithInterfaceFactory() {
  // TODO
}

private func registerNewTVMLElementWithElementFactory() {
  // TODO
}

private func registerNewStylesWithStyleFactory() {
  // TODO
}
