import 'dart:convert';
import 'package:controladorWifi/models/usermodel.dart';
import 'package:controladorWifi/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class ControllerWifi extends StatefulWidget {
  @override
  _ControllerWifiState createState() => _ControllerWifiState();
}

class _ControllerWifiState extends State<ControllerWifi> {
  var users = new List<UserModel>();

  _deleteUser(int id) async {
    API.deleteUser(id).then((response) {
      print(response.body);
    }).catchError((onError) {
      print('Erro: $onError');
    });
  }

  _getUsers() async {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => UserModel.fromJson(model)).toList();
      });
    });
  }

  _postUser() async {
    API
        .postUser(UserModel(
      nome: 'alguma pessoa',
      email: 'algumapessoa@gmail.com',
      whatsapp: '12345678909',
    ))
        .then((response) {
      print(response.body);
    }).catchError((onError) {
      print('Erro: $onError');
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
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Slidable(
            closeOnScroll: true,
            actionExtentRatio: 0.2,
            direction: Axis.horizontal,
            child: ListTile(
              title: Text('${users[index].id}- ${users[index].nome}'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: [
                  IconButton(
                    icon: Icon(Icons.visibility_outlined),
                    onPressed: () {
                      alert(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      _abrirWhatsApp(index);
                    },
                  ),
                ],
              ),
              onTap: () {
                alert(index);
              },
              subtitle: Text(users[index].email),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                icon: Icons.edit,
                color: Colors.black,
                onTap: () {
                  //=> pegar o usuario
                  print('Usuário: ${users[index].nome}');

                  String nomeAnterior = users[index].nome;
                  print('Nome anterior: $nomeAnterior');
                  //joga no campo de texto o nomeAnterior
                  print('Nome anterior jogado no campo de text');

                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext ctx) {
                        final input = Form(
                            child: TextFormField(
                          autofocus: true,
                          initialValue: users[index].nome,
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
                        ));

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
                                    _deleteUser(users[index].id);
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

  void alert(int index) {
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
                    '\nId: ${users[index].id}\nNome: ${users[index].nome}\nEmail: ${users[index].email}\nWhatsapp: ${users[index].whatsapp}\n',
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
                          _abrirWhatsApp(index);
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

  _abrirWhatsApp(int index) async {
    var whatsappUrl =
        "whatsapp://send?phone=+55${users[index].whatsapp}&text=Olá ${users[index].nome}, segue o Token Solicitado.";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
