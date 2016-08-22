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

class Presenter {

  constructor(resourceLoader, searchHandler) {
    this._resourceLoader = resourceLoader;
    this._searchHandler = searchHandler;
  }

  present(template, data, presentation, eventHandler, sender) {
    if (presentation === 'dismiss') {
      navigationDocument.dismissModal();
      return;
    } else if (presentation === 'playVideo') {
      this._playVideo(data, eventHandler);
      return;
    }

    var enhancedData = this._enchancedDataForTemplate(data, template);
    var doc = this._resourceLoader.getDocument(template, enhancedData);

    if(eventHandler) {
      eventHandler.addEventHandlersToDoc(doc);
    }

    if(template === 'search.tvml') {
      this._searchHandler.registerDocForSearch(doc);
    }

    switch (presentation) {
      case 'modal':
        navigationDocument.presentModal(doc);
        break;
      case 'push':
        navigationDocument.pushDocument(doc);
        break;
      case 'menuBar':
        this._presentMenuBarItem(doc, sender);
        break;
    }

  }

  _playVideo(data, eventHandler) {
    // 1:
    var player = new Player();

    // 2:
    var video = new MediaItem('video', data.videoURL);
    video.title = data.title;
    video.subtitle = data.subtitle;
    video.description = data.description;

    // 3:
    player.playlist = new Playlist();
    player.playlist.push(video);

    var overlayData = {
      logo: this._resourceLoader.urlForResource("logo.png")
    };
    var overlay = this._resourceLoader
      .getDocument("videoLogoOverlay.tvml", overlayData);
    player.overlayDocument = overlay;

    player.addEventListener("timeDidChange",
      eventHandler.handlePlaybackUpdates,
      {interval: 5});

    video.resumeTime = data.resumeTime;
    
    // 4:
    player.play();
  }

  _presentMenuBarItem(doc, menuItem) {
    var feature = menuItem.parentNode.getFeature("MenuBarDocument");
    if (feature) {
      var currentDoc = feature.getDocument(menuItem);

      if (!currentDoc) {
        feature.setDocument(doc, menuItem);
      }
    }
  }

  _enchancedDataForTemplate(data, template) {
    var enhancedData = Object.assign({}, data);

    enhancedData.sharedImages = this._sharedImageResources();
    enhancedData = this._resourceLoader.recursivelyConvertFieldsToURLs(enhancedData, "image");

    if(template === 'video.tvml') {
      enhancedData["images"] = this._convertURLValuesInObject(data["images"]);
    }

    return enhancedData;
  }

  _sharedImageResources() {
    var sharedImageNames = {
      heads: "heads.png",
      face: "face.png",
      rock: "rock.png",
      background: "tv_background.png"
    };

    return this._convertURLValuesInObject(sharedImageNames);
  }

  _convertURLValuesInObject(object) {
    return this._resourceLoader.convertNamesToURLs(object);
  }

}
