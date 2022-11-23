
class TattoModelData {

  String? id;
  List? tattos;

  TattoModelData.fromMap(Map <String, dynamic> map) {
    id = map['id'];
    tattos = map['Tattoo'];
  }

}
