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

import UIKit

@IBDesignable
class CalendarView: UIStackView {
  
  fileprivate let monthLabel = UILabel()
  fileprivate let dateLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInitialization()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInitialization()
  }
}

// MARK:- API
extension CalendarView {
  // MARK: Colours
  @IBInspectable var topColor: UIColor? {
    get { return monthLabel.backgroundColor }
    set { monthLabel.backgroundColor = newValue }
  }
  
  @IBInspectable var bottomColor: UIColor? {
    get { return dateLabel.backgroundColor }
    set { dateLabel.backgroundColor = newValue }
  }
  
  @IBInspectable var monthTextColor: UIColor? {
    get { return monthLabel.textColor }
    set { monthLabel.textColor = newValue }
  }
  
  @IBInspectable var dateTextColor: UIColor? {
    get { return dateLabel.textColor }
    set { dateLabel.textColor = newValue }
  }
  
  // MARK: Data
  @IBInspectable var monthString: String? {
    get { return monthLabel.text }
    set { monthLabel.text = newValue == .none ? "" : newValue!.uppercased() }
  }
  
  @IBInspectable var dateString: String? {
    get { return dateLabel.text }
    set { dateLabel.text = newValue }
  }
}

// MARK:- Initial layout and configuration
extension CalendarView {
  fileprivate func sharedInitialization() {
    setAppearanceDefaults()
    prepareLayout()
  }
  
  private func prepareLayout() {
    addArrangedSubview(monthLabel)
    addArrangedSubview(dateLabel)
    
    axis = .vertical
    distribution = .fill
    alignment = .fill
    
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    translatesAutoresizingMaskIntoConstraints = false
    
    monthLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
    
    dateLabel.heightAnchor.constraint(equalTo: monthLabel.heightAnchor, multiplier: 3).isActive = true
  }
  
  private func setAppearanceDefaults() {
    topColor = UIColor(red: 0, green: 184.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    bottomColor = UIColor(white: 244.0/255.0, alpha: 1.0)
    monthTextColor = UIColor(white: 1.0, alpha: 1.0)
    dateTextColor = UIColor(white: 85.0/255.0, alpha: 1.0)
    
    monthLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightRegular)
    dateLabel.font = UIFont.systemFont(ofSize: 70, weight: UIFontWeightLight)
    
    monthLabel.textAlignment = .center
    dateLabel.textAlignment = .center
    
    monthLabel.adjustsFontSizeToFitWidth = true
    dateLabel.adjustsFontSizeToFitWidth = true
    
    monthLabel.minimumScaleFactor = 0.1
    dateLabel.minimumScaleFactor = 0.1
    
    monthString = "MNTH"
    dateString = "00"
  }
}



