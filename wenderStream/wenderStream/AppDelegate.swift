/*
 * Copyright (c) 2016 Razeware LLC
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
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TVApplicationControllerDelegate {
  
  var window: UIWindow?
  var appController: TVApplicationController?
  
  // MARK: Javascript Execution Helper
  
  func executeRemoteMethod(_ methodName: String, completion: @escaping (Bool) -> Void) {
    appController?.evaluate(inJavaScriptContext: { (context: JSContext) in
      let appObject : JSValue = context.objectForKeyedSubscript("App")
      
      if appObject.hasProperty(methodName) {
        appObject.invokeMethod(methodName, withArguments: [])
      }
      }, completion: completion)
  }
  
  // MARK: UIApplicationDelegate
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    
    // Create the TVApplicationControllerContext for this application and set the properties that will be passed to the `App.onLaunch` function in JavaScript.
    let appControllerContext = TVApplicationControllerContext()
    
    // The JavaScript URL is used to create the JavaScript context for your TVMLKit application. Although it is possible to separate your JavaScript into separate files, to help reduce the launch time of your application we recommend creating minified and compressed version of this resource. This will allow for the resource to be retrieved and UI presented to the user quickly.
    if let jsURL = Bundle.main.url(forResource: "application", withExtension: "js") {
      appControllerContext.javaScriptApplicationURL = jsURL
    }
    
    if let launchOptions = launchOptions {
      for (kind, value) in launchOptions {
        appControllerContext.launchOptions[kind.rawValue] = value
      }
    }
    
    appController = TVApplicationController(context: appControllerContext, window: window, delegate: self)
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and stop playback
    executeRemoteMethod("onWillResignActive", completion: { (success: Bool) in
      // ...
    })
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    executeRemoteMethod("onDidEnterBackground", completion: { (success: Bool) in
      // ...
    })
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    executeRemoteMethod("onWillEnterForeground", completion: { (success: Bool) in
      // ...
    })
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    executeRemoteMethod("onDidBecomeActive", completion: { (success: Bool) in
      // ...
    })
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    executeRemoteMethod("onWillTerminate", completion: { (success: Bool) in
      // ...
    })
  }
  
  // MARK: TVApplicationControllerDelegate
  
  func appController(_ appController: TVApplicationController, didFinishLaunching options: [String: Any]?) {
    print("\(#function) invoked with options: \(options)")
  }
  
  func appController(_ appController: TVApplicationController, didFail error: Error) {
    print("\(#function) invoked with error: \(error)")
    
    let title = "Error Launching Application"
    let message = error.localizedDescription
    let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert )
    
    self.appController?.navigationController.present(alertController, animated: true, completion: {
      // ...
    })
  }
  
  func appController(_ appController: TVApplicationController, didStop options: [String: Any]?) {
    print("\(#function) invoked with options: \(options)")
  }
  
  func appController(appController: TVApplicationController,
                     evaluateAppJavaScriptInContext jsContext: JSContext) {
    
    jsContext.setObject(ResourceLoader.self, forKeyedSubscript: "NativeResourceLoader" as NSString)
  }
}

