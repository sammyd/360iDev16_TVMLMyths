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
3. TVML is for media playback
4. You can't include native functionality
5. You can't use TVML from a native app


---

![](images/servers.jpg)

# [fit] You _have_ to<br>use a _server_


---

# In-bundle TVML

- TVML engine just processes text
- Doesn't care where it comes from
- Server offers advantages, but not required
- 







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

# [fit] the _entirety_ of<br>JavaScript<br>at your _fingertips_

---

# [fit] 😱

---

![](images/roof.jpeg)

# [fit] Templating<br>Engine

---

# [fit] {{MUSTACHE}}

---



---

![](images/tv.jpeg)

# [fit] TVML is for<br>_media_ playback


---

![](images/laptop-phone.jpeg)

# [fit] You can't<br>include _native_<br>functionality


---

![](images/imac.jpeg)

# [fit] You can't<br>use TVML<br>in _native_ apps


---

![](images/hand.jpeg)

# _Five Myths_ about TVML

1. ~~You have to use a server~~
2. ~~You write TVML in JavaScript strings~~
3. ~~TVML is only for media playback~~
4. ~~You can't include native functionality~~
5. ~~You can't use TVML from a native app~~

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

