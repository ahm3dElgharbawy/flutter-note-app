class NoteModel {
  int? id;
  String? note;
  String? title;
  String? color;
  String? dateTime;

  NoteModel({this.id, this.note, this.title, this.color, this.dateTime});

  NoteModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    note = json['note'];
    title = json['title'];
    color = json['color'];
    dateTime = json['date_time'];
  }
}
