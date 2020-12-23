import 'dart:async';
import 'dart:convert';
import 'package:controladorWifi/models/usermodel.dart';
import 'package:controladorWifi/screens/login_screen.dart';
import 'package:controladorWifi/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/usermodel.dart';

class ControllerWifi extends StatefulWidget {
  @override
  _ControllerWifiState createState() => _ControllerWifiState();
}

class _ControllerWifiState extends State<ControllerWifi> {
  final _streamController = StreamController<List<UserModel>>.broadcast();

  String nome;
  String email;
  String whatsapp;

  _getUsers() async {
    API.getUsers().then((response) {
      Iterable list = json.decode(response.body);

      _streamController
          .add(list.map((model) => UserModel.fromJson(model)).toList());
    });
  }

  _deleteUser(int id) async {
    API.deleteUser(id).then((response) {
      print(response.body);
    }).catchError((onError) {
      print('Erro: $onError');
    });
  }

  _putUser(UserModel userModel) async {
    API.editUser(userModel).then((response) {
      print(response.body);
      print(response.status);
    }).catchError((e) {
      print(e);
    });
  }

  _postUser() async {
    API
        .postUser(UserModel(
      nome: 'alguma pessoa',
      email: 'algumapessoa@gmail.com',
      whatsapp: '(75) 99119-9329',
    ))
        .then((response) {
      print(response.body);
    }).catchError((onError) {
      print('Erro1: $onError');
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controlador wifi'),
        centerTitle: true,
        actions: [
          InkWell(
            child: Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao conectar !! '));
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<UserModel> users = snapshot.data;

          return _listview(users);
        },
      ),
    );
  }

  _listview(users) {
    return Container(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          UserModel userModel = users[index];
          return Slidable(
            closeOnScroll: true,
            actionExtentRatio: 0.2,
            direction: Axis.horizontal,
            child: ListTile(
              title: Text(userModel.nome),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: [
                  IconButton(
                    icon: Icon(Icons.visibility_outlined),
                    onPressed: () {
                      alert(userModel);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      _abrirWhatsApp(userModel);
                    },
                  ),
                ],
              ),
              onTap: () {
                alert(userModel);
              },
              subtitle: Text(userModel.email),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                icon: Icons.edit,
                color: Colors.black,
                onTap: () {
                  //=> pegar o usuario
                  print('Usuário: ${userModel.nome}');

                  String nomeAnterior = userModel.nome;
                  print('Nome anterior: $nomeAnterior');
                  //joga no campo de texto o nomeAnterior
                  print('Nome anterior jogado no campo de text');

                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext ctx) {
                        final input = Column(
                          children: [
                            TextFormField(
                              autofocus: true,
                              initialValue: userModel.nome,
                              decoration: InputDecoration(
                                  hintText: 'Nome',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Este campo não pode ficar vazio';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                nome = value;
                              },
                            ),
                            TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              initialValue: userModel.email,
                              decoration: InputDecoration(
                                  hintText: 'E-mail',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Este campo não pode ficar vazio';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                email = value;
                              },
                            ),
                            TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.phone,
                              initialValue: userModel.whatsapp,
                              decoration: InputDecoration(
                                  hintText: 'Whatsapp',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Este campo não pode ficar vazio';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                whatsapp = value;
                              },
                            ),
                          ],
                        );

                        return AlertDialog(
                          title: Text('Editar nome'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[input],
                            ),
                          ),
                          actions: <Widget>[
                            RaisedButton(
                              color: Colors.white,
                              child: Text('Cancelar',
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            RaisedButton(
                              color: Colors.white,
                              child: Text('Salvar',
                                  style: TextStyle(color: Colors.greenAccent)),
                              onPressed: () {
                                //atualiza a informação no banco de dados
                                //salva um dado na tabela LOG dizendo que atualizou um dado
                                print('dados atualizados');
                                print('dados salvos na tabela LOG');

                                _putUser(UserModel(
                                    id: userModel.id,
                                    email: email,
                                    nome: nome,
                                    whatsapp: whatsapp));
                                Navigator.of(ctx).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
              IconSlideAction(
                caption: 'Excluir',
                icon: Icons.block,
                color: Colors.red[400],
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Text('Tem certeza?'),
                          content: Text(
                              'Esta ação irá excluir o usuário selecionado!'),
                          actions: <Widget>[
                            RaisedButton(
                              color: Colors.greenAccent,
                              child: Text('Cancelar',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            RaisedButton(
                                color: Colors.white,
                                child: Text('Excluir',
                                    style: TextStyle(color: Colors.red)),
                                onPressed: () {
                                  setState(() {
                                    //alguma ação para excluir o usuario
                                    _deleteUser(userModel.id);
                                  });
                                  Navigator.of(ctx).pop();
                                })
                          ],
                        );
                      });
                },
              ),
            ],
            actionPane: SlidableBehindActionPane(),
          );
        },
      ),
    );
  }

  void alert(UserModel usMd) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(
              'Dados do usuário',
              style: TextStyle(color: Colors.black54),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    '\nId: ${usMd.id}\nNome: ${usMd.nome}\nEmail: ${usMd.email}\nWhatsapp: ${usMd.whatsapp}\n',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                height: 40,
                color: Colors.blue[900],
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.message,
                        size: 20.0,
                        color: Colors.blue,
                      ),
                      FlatButton(
                        child: Text('Entrar em contato',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 20.0,
                            )),
                        onPressed: () {
                          //vai entrar em contato no whatsapp
                          _abrirWhatsApp(usMd);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                color: Colors.red[400],
                child: FlatButton(
                  hoverColor: Colors.black87,
                  child: Text('Ok',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 20.0,
                      )),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ),
            ],
          );
        });
  }

  _abrirWhatsApp(UserModel usMd) async {
    var whatsappUrl =
        "whatsapp://send?phone=+55${usMd.whatsapp}&text=Olá ${usMd.nome}, segue o Token Solicitado:\n";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
