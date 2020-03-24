class Record{
  final int id;
  final String title;
  bool isFavourite = false;

  Record({this.id, this.title});

  changeFavouriteState(){
    this.isFavourite = !this.isFavourite;
  }
}