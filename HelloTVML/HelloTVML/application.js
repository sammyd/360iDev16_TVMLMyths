//# sourceURL=application.js

/*
 application.js
 HelloTVML
 
 Copyright (c) 2016 Razeware. All rights reserved.
*/

/*
 * This file provides an example skeletal stub for the server-side implementation 
 * of a TVML application.
 *
 * A javascript file such as this should be provided at the tvBootURL that is 
 * configured in the AppDelegate of the TVML application. Note that  the various 
 * javascript functions here are referenced by name in the AppDelegate. This skeletal 
 * implementation shows the basic entry points that you will want to handle 
 * application lifecycle events.
 */

/**
 * @description The onLaunch callback is invoked after the application JavaScript 
 * has been parsed into a JavaScript context. The handler is passed an object 
 * that contains options passed in for launch. These options are defined in the
 * swift or objective-c client code. Options can be used to communicate to
 * your JavaScript code that data and as well as state information, like if the 
 * the app is being launched in the background.
 *
 * The location attribute is automatically added to the object and represents 
 * the URL that was used to retrieve the application JavaScript.
 */
App.onLaunch = function(options) {
  var resourceLoader = new ResourceLoaderJS(NativeResourceLoader.create());

  var initialDoc = resourceLoader.getDocument("hello.tvml");
  navigationDocument.pushDocument(initialDoc);

  initialDoc.addEventListener("select", handleEvent);
  initialDoc.addEventListener("play", handleEvent);
};

class ResourceLoaderJS {
  constructor(nativeResourceLoader) {
    this.nativeResourceLoader = nativeResourceLoader;
    this.domParser = new DOMParser();
  }
  
  getDocument(name) {
    var docString = this.nativeResourceLoader.loadBundleResource(name);
    
    return this.domParser.parseFromString(docString, "application/xml");
  }
}

function playVideo(title, url) {
  var player = new Player();
  var video = new MediaItem('video', url);
  video.title = title;
  
  player.playlist = new Playlist();
  player.playlist.push(video);
  
  player.play();
}

function handleEvent(event) {
  var buttonId = event.target.getAttribute("id");
  
  if(buttonId === "play") {
    playVideo("Hello TVML!",
              "https://wolverine.raywenderlich.com/books/tvos-apprentice/helloTVML/hls_playlist.m3u8");
  }
}



/**
 * This convenience funnction returns an alert template, which can be used to present errors to the user.
 */
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
}
