class Cast{

  List<Data> cats = [];

  Cast.fromJsonList( List<dynamic>? jsonList ){
    
    if(jsonList == null) return;

    jsonList.forEach((item) { 
      final cat = Data.fromJsonMap(item);
      cats.add(cat);
    });

  }

}

class Data {
  String? fact;
  int? length;

  Data({this.fact,this.length});

  Data.fromJsonMap(Map<String,dynamic> json){
    fact   = json['fact'];
    length = json['length'];
  }

}
