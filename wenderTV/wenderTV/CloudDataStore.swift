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

import Foundation
import JavaScriptCore

// 1:
@objc protocol CloudDataStoreExport: JSExport {
  // 2:
  func getItem(_ key: String) -> AnyObject?
  func setItem(_ key: String, _ value: AnyObject)
  // 3:
  static func create() -> CloudDataStoreExport
}


@objc class CloudDataStore: NSObject {
  override init() {
    super.init()
    
    NotificationCenter.default.addObserver(self,
      selector: #selector(storeDidChange(_:)),
      name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
      object: NSUbiquitousKeyValueStore.default())
    
    NSUbiquitousKeyValueStore.default().synchronize()
  }
  
  func storeDidChange(_ notification: Notification) {
    if let ubiquitousKeyValueStore = notification.object as? NSUbiquitousKeyValueStore {
      ubiquitousKeyValueStore.synchronize()
    }
  }
}


extension CloudDataStore: CloudDataStoreExport {
  // 1:
  func getItem(_ key: String) -> AnyObject? {
    return NSUbiquitousKeyValueStore.default().object(forKey: key)
  }
  
  // 2:
  func setItem(_ key: String, _ value: AnyObject) {
    NSUbiquitousKeyValueStore.default().set(value, forKey: key)
  }
  
  // 3:
  static func create() -> CloudDataStoreExport {
    return CloudDataStore()
  }
}



