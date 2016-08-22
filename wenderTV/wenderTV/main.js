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


App.onLaunch = function(options) {
  evaluateScripts(options.initialJSDependencies, function(success){
    if (success) {
      var resourceLoader = new ResourceLoaderJS(NativeResourceLoader.create());
      var dataController = new DataController(resourceLoader);
      var searchHandler = new SearchHandler(resourceLoader, dataController);
      var presenter = new Presenter(resourceLoader, searchHandler);
      var eventHandler = new EventHandler(presenter, dataController);

      presenter.present("rootMenu.tvml", null, "push", eventHandler);
    } else {
      var alert = createAlert("Evaluate Scripts Error", "There was an error attempting to evaluate the external JavaScript files.");
      navigationDocument.presentModal(alert);

      throw ("Playback Example: unable to evaluate scripts.");
    }
  });
};

var createAlert = function(title, description) {  
  var alertString = `<?xml version="1.0" encoding="UTF-8" ?>
    <document>
      <alertTemplate>
        <title>${title}</title>
        <description>${description}</description>
      </alertTemplate>
    </document>`

  var parser = new DOMParser();
  var alertDoc = parser.parseFromString(alertString, "application/xml");
  return alertDoc
};
