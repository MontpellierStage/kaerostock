class Utilisateur{

  int uid = 0;
  String unom="";
  String uprenom = "";

  Utilisateur({required this.uid, required this.unom, required this.uprenom});

  factory Utilisateur.fromJson(Map<String, dynamic>json)
  {
    return Utilisateur(
      uid: int.parse(json['Uid']),
      unom: json['Unom'] as String,
      uprenom: json['Uprenom'] as String);
  }
}

class Outil{

  int oid = 0;
  int locid = 0;
  String olibelle ="";

  Outil({required this.oid, required this.locid, required this.olibelle});

  factory Outil.fromJson(Map<String, dynamic>json){
    return Outil(oid: int.parse(json['Aid']),
        locid: int.parse(json['LOCid']),
        olibelle: json['Alibelle'] as String);
  }
}