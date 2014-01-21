import 'dart:html';

var query = 'kittens';
var btn = querySelector("#view-kittens");
var display = querySelector("#display");

List<Kitten> kittens = [];

var flickrSearch ='https://secure.flickr.com/services/rest/?' +
'method=flickr.photos.search&' +
'api_key=90485e931f687a9b9c2a66bf58a3861a&' +
'text=' + Uri.encodeQueryComponent(query) + '&' +
'safe_search=1&' +
'content_type=1&' +
'sort=interestingness-desc&' +
'per_page=20';

void main() {
  querySelector("#sample_text_id")
    ..text = "Click me!"
    ..onClick.listen(reverseText);
  
  btn..onClick.listen(viewKittens);
}

void viewKittens(Event e) {
  log('view kittens');
  
  HttpRequest.request('flickr_response.xml')
    .then(processKittens);
//    .catchError(kittensError);
}

void processKittens(HttpRequest request) {
  var xmlDoc = request.responseXml;

  try {
    var root = xmlDoc.querySelector('rsp');
    var root_attr = root.attributes;
    var status = root_attr['stat'];
    
    log('Status: $status');
    
    var photos = xmlDoc.querySelectorAll('photo');
    
    photos.forEach((photo) {
      kittens.add(new Kitten.fromAttributes(photo.attributes));
    });
    displayKittens();
    
  } catch(e) {
    print('Request URI doesn\'t have correct XML formatting.');
  }
}

log(String txt) {
  var p = new Element.tag('p');
  p.text = txt;
  
  display.append(p);
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}

void displayKittens() {
  kittens.forEach((kitten) {
    var img = new Element.tag('img');
    img.src = kitten.constructImageUrl();
    
    display.append(img);
  });
}


class Kitten {
  
  String _title;
  Map<String, String> properties = {
     'id': '',
     'owner': '',
     'secret': '',
     'server': '',
     'farm': '',
     'ispublic': '',
     'isfriend': '',
     'isfamily': '',
  };
  
  Kitten() {}
  
  String toString() => kittenName;
  String get kittenName => _title.isEmpty ? 'No Name Kitty' : _title;
  
  Kitten.fromAttributes(Map attributes) {
    properties.forEach((k,v) {
      properties[k.toString()] = attributes[k].toString();
    });
    
    this._title = attributes['title'].toString();
  }
  
  String constructImageUrl() {
    return "http://farm" + this.properties['farm'] +
        ".static.flickr.com/" + this.properties['server'] +
        "/" + this.properties['id'] +
        "_" + this.properties['secret'] +
        "_s.jpg";
  }
}