![](images/tv-beach.jpeg)

# [fit] TVML Myths
## [fit] or why you shouldn't write TVML off... _yet_

### Sam Davies _|_ @iwantmyrealname _|_ 360|iDev 2016

---
![](images/apple-tv.jpeg)

# [fit] What is<br>_TVML_?



---

![](images/question.jpeg)

# [fit] Why is TVML so<br>_misunderstood_?


---

![](images/hand.jpeg)

# _Five Myths_ about TVML

1. You have to use a server
2. You write TVML in JavaScript strings
3. Layout includes data
4. TVML is for media playback
5. Either TVML or native


---

![](images/servers.jpg)

# [fit] You _have_ to<br>use a _server_

---

![](images/coding.jpeg)

# [fit] demo

---

![](images/javascript.jpeg)

# [fit] You write TVML in<br>_JavaScript_ strings


---

#  Sample Code

```javascript
App.onLaunch = function(options) {
  var template = '<document>' +
  '<loadingTemplate>' +
  '<activityIndicator>' +
  '<text>Hello World!</text>' +
  '</activityIndicator>' +
  '</loadingTemplate>' +
  '</document>';
   var templateParser = new DOMParser();
   var parsedTemplate = templateParser.parseFromString(template, "application/xml");
   navigationDocument.pushDocument(parsedTemplate);
}
```

---

# In-bundle TVML

- TVML engine just processes text
- Doesn't care where it comes from
- Server offers advantages, but not required

---

![](images/coding.jpeg)

# [fit] demo

---

![](images/tree-cross.jpeg)

# [fit] Layout<br>_includes_ data

---

```xml
            <infoList>
              <info>
                <header>
                  <title>Presenter</title>
                </header>
                <text>Sam Davies</text>
              </info>
              <info>
                <header>
                  <title>Tags</title>
                </header>
                  <text>Short</text>
                  <text>Glasses</text>
                  <text>Funny Accent</text>
              </info>
            </infoList>
            <stack>
              <title>Droning-On II: Return of the Tedium</title>
            </stack>
```

---

# [fit] the _entirety_ of<br>JavaScript<br>at your _fingertips_

---

# [fit] 😱

---

![](images/roof.jpeg)

# [fit] Templating<br>Engine

---

# [fit] {{MUSTACHE}}

---

```javascript
class ResourceLoaderJS {
  ...
  
  getDocument(name) {
    var docString = this.nativeResourceLoader.loadBundleResource(name);

    return this.domParser.parseFromString(docString, "application/xml");
  }
}
```

---

```javascript
class ResourceLoaderJS {
  ...
  
  getDocument(name, data) {
    data = data || {};
    var docString = this.nativeResourceLoader.loadBundleResource(name);
    var rendered = Mustache.render(docString, data);

    return this.domParser.parseFromString(rendered, "application/xml");
  }
}
```

---

```javascript
class ResourceLoaderJS {
  ...

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
}
```

---

```xml
            <infoList>
              <info>
                <header>
                  <title>Presenter</title>
                </header>
                <text>Sam Davies</text>
              </info>
              <info>
                <header>
                  <title>Tags</title>
                </header>
                  <text>Short</text>
                  <text>Glasses</text>
                  <text>Funny Accent</text>
              </info>
            </infoList>
            <stack>
              <title>Droning-On II: Return of the Tedium</title>
            </stack>
```

---

```xml
            <infoList>
              <info>
                <header>
                  <title>Presenter</title>
                </header>
                <text>{{presenter}}</text>
              </info>
              <info>
                <header>
                  <title>Tags</title>
                </header>
                {{#tags}}
                  <text>{{.}}</text>
                {{/tags}}
              </info>
            </infoList>
            <stack>
              <title>{{title}}</title>
            </stack>
```

---

```json

  {
    "presenter": "Sam Davies",
    "tags": [
      "Short",
      "Glasses",
      "Funny Accent"
    ],
    "title": "Droning-On II: Return of the Tedium"
  }
```

---

![](images/coding.jpeg)

# [fit] demo

---

![](images/tv.jpeg)

# [fit] TVML is for<br>_media_ playback


---

![](images/laptop-phone.jpeg)

# [fit] Either TVML<br>_or_ native

---





---

![](images/hand.jpeg)

# _Five Myths_ about TVML

1. ~~You have to use a server~~
2. ~~You write TVML in JavaScript strings~~
3. ~~Layout includes data~~
4. ~~TVML is for media playback~~
5. ~~Either TVML or native~~

---

![](images/do-not-enter.jpeg)

# [fit] TVML<br>Limitations


---

![](images/road-crossing.jpeg)

# [fit] __try__ it.
# [fit] you might __like__ it.


---

![](images/sam.jpg)

## git.io/v6MsR
## github.com/sammyd
## @iwantmyrealname
## raywenderlich.com

