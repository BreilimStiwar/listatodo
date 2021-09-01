class Cat {

  String? currentpage;
  List<Data>? data;

  Cat({this.currentpage,this.data});

  factory Cat.fromJson(Map<String, dynamic> json){
    
    var list = json['data'] as List;
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return Cat(
      currentpage : json['current_page'],
      data        : dataList
    );
  
  }

}

class Data {

  String? fact;
  int? length;

  Data({this.fact, this.length});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fact   : json['fact'],
    length : json['length']
  );
  
}