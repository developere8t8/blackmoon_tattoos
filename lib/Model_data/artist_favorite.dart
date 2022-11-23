class ArtestFavorite {
  String? id;
  String? artestId;
  String? userId;
  //
  //bool? fav;
  ArtestFavorite({
    required this.id,
    required this.artestId,
    required this.userId,
    //required this.fav
  });
  ArtestFavorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    artestId = map['artestId'];
    userId = map['userId'];
    //fav = map['fav'];
  }
  Map<String, dynamic> tMap() {
    return {
      'id': id, 'artestId': artestId, 'userId': userId, //'fav': fav
    };
  }
}
