class UserModel {
  UserModel({this.id, this.nome, this.email, this.whatsapp});

  final int id;
  final String nome;
  final String email;
  final String whatsapp;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      nome: json["nome"],
      email: json["email"],
      whatsapp: json["whatsapp"]);

  Map<String, dynamic> toJson() => {
        'id': '$id',
        'nome': '$nome',
        'email': '$email',
        'whatsapp': '$whatsapp',
      };
}
