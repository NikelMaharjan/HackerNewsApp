import 'dart:convert';

class ItemModel {
  String? by;
  String? text;   //for comments // we only added this later after defining db
  //.toDB and .fromDb error since we havenot defined text column in table.. so we create onUpgrade
  int? descendants;
  int? id;
  int? parent;
  List<int>? kids;
  int? score;
  int? time;
  String? title;
  String? type;
  String? url;
  bool? deleted;
  bool? dead;

  ItemModel(
      {this.by,
        this.descendants,
        this.text,
        this.id,
        this.parent,
        this.kids,
        this.deleted,
        this.dead,
        this.score,
        this.time,
        this.title,
        this.type,
        this.url});

  ItemModel.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    text = json['text'];
    descendants = json['descendants'];
    id = json['id'];
    parent = json['parent'];
    deleted = json['deleted'];
    dead = json['dead'];
    kids = json['kids'] == null ? []: json['kids']?.cast<int>();
    score = json['score'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  ItemModel.fromDB(Map<String, dynamic> json) {
    by = json['by'];
    text = json['text'];
    descendants = json['descendants'];
    id = json['id'];
    parent = json['parent'];
    deleted = json['deleted'] == 1;  //if 1, deleted value will set to true
    dead = json['dead'] == 1;
    kids = jsonDecode(json['kids'])== null ? [] : jsonDecode(json['kids']).cast<int>();
    score = json['score'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['text'] = this.text;
    data['descendants'] = this.descendants;
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['kids'] = this.kids;
    data['deleted'] = this.deleted;
    data['dead'] = this.dead;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }

  Map<String, dynamic> toDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['descendants'] = this.descendants;
    data['text'] = this.text;
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['kids'] = jsonEncode(this.kids);
    data['deleted'] = this.deleted == true ? 1: 0;
    data['dead'] = this.dead == true ? 1 : 0;
    data['score'] = this.score;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
