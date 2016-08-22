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

class EventHandler {
  constructor(presenter, dataController) {
    this._presenter = presenter;
    this._dataController = dataController;
    this.handleEvent = this.handleEvent.bind(this);
    this.handlePlaybackUpdates =
      this.handlePlaybackUpdates.bind(this);
  }

  addEventHandlersToDoc(doc) {
    doc.addEventListener("select", this.handleEvent);
  }

  handlePlaybackUpdates(event) {
    var url = event.target.currentMediaItem.url;
    var progress = event.time;
    this._dataController.saveProgressForVideoAtURL(url, progress);
  }

  handleEvent(event) {
    var element = event.target;
    var template = element.getAttribute("template"),
      presentation = element.getAttribute("presentation"),
      data = element.getAttribute("data"),
      action = element.getAttribute("action");

    var retrievedData = this._dataController.retrieveData(data, presentation);

    if(presentation) {
      this._presenter.present(template, retrievedData, presentation, this, element);
    }
  }

}
