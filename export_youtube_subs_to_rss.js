function exportSubscriptions() {
   var channels = [];
   var inChannels = false;
   var channelURLFragment = "www.youtube.com/channel/";

   var links = document.querySelectorAll("a#main-link");
   for(var i = 0; i < links.length; i++) {
      var title = links[i].querySelector("yt-formatted-string[title]").innerText;
         var channelId = getChannelId(links[i]);
         if(channelId) {
            inChannels = true;
         }

         if(inChannels) {
            if(!channelId) {
               break;
            }

            channels.push({"title":title, "id":channelId});
         }
   }

   var xml = buildXML(channels);
   var fileType = "text/plain";
   var blob = new Blob([xml], {type: fileType});
   var blobURL = window.URL.createObjectURL(blob);
   var filename = "youtubeSubscriptions.opml";
   var downloadLink = document.createElement("a");
   downloadLink.setAttribute("href", blobURL);
   downloadLink.setAttribute("download", filename);
   downloadLink.dataset.downloadurl = fileType + ":" + filename + ":" + blobURL;
   downloadLink.click();
}

function getChannelId(link) {
   try {
      if (link.data.browseEndpoint.browseId.startsWith("UC")) {
         return link.data.browseEndpoint.browseId;
      }
   } catch {
   }
}

function buildXML(channels) {
   var xmlDoc = document.implementation.createDocument("", "", null);
   var opml = xmlDoc.createElement("opml");
   opml.setAttribute("version", "1.0");

   var head = xmlDoc.createElement("head");
   var title = xmlDoc.createElement("title");
   title.innerHTML = "YouTube Subscriptions as RSS";
   head.appendChild(title);
   opml.appendChild(head);

   var body = xmlDoc.createElement("body");
   var parentOutline = xmlDoc.createElement("outline");
   parentOutline.setAttribute("text", "YouTube Subscriptions")
   parentOutline.setAttribute("title", "YouTube Subscriptions")

   for(var j = 0; j < channels.length; j++) {
      var outline = xmlDoc.createElement("outline");
      outline.setAttribute("type", "rss");
      outline.setAttribute("text", channels[j].title);
      outline.setAttribute("title", channels[j].title);
      outline.setAttribute("xmlUrl", "https://www.youtube.com/feeds/videos.xml?channel_id=" + channels[j].id);
      parentOutline.appendChild(outline);
   }

   body.appendChild(parentOutline);

   opml.appendChild(body);
   xmlDoc.appendChild(opml);

   var s = new XMLSerializer();
   return s.serializeToString(xmlDoc);
}

exportSubscriptions()
