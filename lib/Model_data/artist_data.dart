class ArtistData {
  String? name;
  String? type;
  String? id;
  List? tatto;
  String? thumbnail;
  bool? active;
  String? calendlyLink;
  ArtistData({
    this.name,
    this.type,
    this.id,
    this.tatto,
    this.thumbnail,
    this.active,
    this.calendlyLink,
  });
  ArtistData.fromMap(Map<String, dynamic> map) {
    name = map['NameArtist'];
    type = map['Type'];
    id = map['id'];
    tatto = map['Tattos'];
    thumbnail = map['thumbnail'];
    active = map['active'];
    calendlyLink = map['calendlyLink'];
  }
}
