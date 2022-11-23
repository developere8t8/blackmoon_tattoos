class TattoFavrite {
  String? userId;
  String? id;
  String? tattooId;

  TattoFavrite({
    this.userId,
    this.id,
    this.tattooId,
  });
  TattoFavrite.fromMap(Map<String, dynamic> tattofav) {
    userId = tattofav['userId'];
    id = tattofav['id'];
    tattooId = tattofav['tattooId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'tattooId': tattooId,
    };
  }
}
