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


class ResourceLoaderJS {
  constructor(nativeResourceLoader) {
    this.nativeResourceLoader = nativeResourceLoader;
    this.domParser = new DOMParser();
  }

  getDocument(name, data) {
    data = data || {};
    var docString = this.nativeResourceLoader.loadBundleResource(name);
    var rendered = Mustache.render(docString, data);

    return this.domParser.parseFromString(rendered, "application/xml");
  }

  getJSON(name) {
    var jsonString = this.nativeResourceLoader.loadBundleResource(name);
    var json = JSON.parse(jsonString);
    return json;
  }

  urlForResource(name) {
    return this.nativeResourceLoader.urlForResource(name);
  }

  convertNamesToURLs(data) {
    var convertedData = {};
    for (var prop in data) {
      convertedData[prop] = this.urlForResource(data[prop]);
    }
    return convertedData;
  }

  recursivelyConvertFieldsToURLs(data, key) {
    var dataCopy = Object.assign({}, data);
    var urlForResource = this.urlForResource.bind(this);
    recursiveApplyOnKey(dataCopy, key, function(value) {
      if (typeof(value) === 'string') {
        return urlForResource(value);
      } else {
        return value;
      }
    });
    return dataCopy;
  }
}

function recursiveApplyOnKey(obj, key, callback) {
  if (obj.hasOwnProperty(key)) {
    obj[key] = callback(obj[key]);
  }
  for(var p in obj) {
    if(typeof(obj[p]) === "object") {
      recursiveApplyOnKey(obj[p], key, callback);
    }
  }
}
