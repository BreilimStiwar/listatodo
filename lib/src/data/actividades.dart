class Actividades{

  String _title, _description, _status;

  Actividades(this._title,this._description, this._status);

  String get title       => _title;
  String get description => _description;
  String get status      => _status;

  set title(String getTitle){
    if(getTitle.length <= 50){
      this._title = getTitle;
    }
  }

  set description(String getDescription){
    if(getDescription.length <= 255){
      this._description = getDescription;
    }
  }

  set status(String getStatus) => this._status = getStatus;
    
}