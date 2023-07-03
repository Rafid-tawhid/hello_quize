class Perticipents {
  String id='';
  String name='';
  String number='';
  String time='';

  Perticipents(this.id, this.name, this.number, this.time);

  Map<String,dynamic> toMap(){
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['number'] = number;
    map['time'] = time;
    return map;
  }

  Perticipents.fromMap(dynamic map) {
    id=map['id'];
    name=map['name'];
    number=map['number'];
    time=map['time'];
  }
}