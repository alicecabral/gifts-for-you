import 'package:flutter/material.dart';

import 'package:gifts_4_you/selecao_de_gostos.dart';
import 'package:gifts_4_you/login.dart';
import 'package:gifts_4_you/db_helper.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static db_helper  _db = new db_helper();
  String _email = "";
  String _name = "";
  String _password ="";
  String _infoText =
      "Ainda não possui uma conta no gifts 4U? Clique aqui e se cadstre!";
  void _resetField() {
    setState(() {
      nameController.text = "";
      emailController.text = "";
      passwordController.text = "";
      passwordConfirmController.text = "";
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(246 , 246, 246, 1),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, //alarga o máximo que consegue para pegar a largura toda
                  children: <Widget>[
                    Container(
                        child: Image.asset(
                          'assets/images/gifts_for_u_logo.png',
                          height: 300,
                          width: 300,
                        ),
                        width: 300,
                        height: 300),
                    Text(
                      "NOVO USUÁRIO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),

                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Nome",
                            labelStyle: TextStyle(color: Colors.black)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        controller: nameController,
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) return "Insira seu nome!";
                          }
                        }),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      controller: emailController,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) return "Insira seu email!";
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (!emailValid) {
                          return "Favor inserir um email válido!";
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(color: Colors.black)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      controller: passwordController,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) return "Insira sua senha!";
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Confirmação de senha",
                          labelStyle: TextStyle(color: Colors.black)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      controller: passwordConfirmController,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) return "Insira sua senha!";
                          if (passwordConfirmController.text
                                  .compareTo((passwordController.text)) !=
                              0) {
                            return "As senhas digitadas não são iguais";
                          }
                        }
                      },

                    ),
                    Row(
                      children:<Widget> [
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            _resetField();
                          },
                          iconSize: 20,
                        ),
                        Text(
                            'Limpar campos',
                            style: TextStyle(
                                color: Colors.black)),
                      ],
                    ),
                    Padding(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(122, 140, 240, 1),
                              textStyle: TextStyle(
                                fontSize: 20,
                              )),
                          child: const Text('Cadastrar'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _name = nameController.text;
                              _password = passwordController.text;
                              _email = emailController.text;
                              print("email: $_email ; nome: $_name; senha= _password ");
                              Map<String, dynamic> user = {
                                "nome" : _name,
                                "senha" : _password,
                                "email" : _email
                              } ;
                              await _db.Insert("usuario",user,"email=?",[user['email']]);
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 300,
                                    color: Color.fromRGBO(65, 65, 65, 1),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                              'Usuário cadastrado com sucesso!',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromRGBO(
                                                    122, 140, 240, 1),
                                                textStyle: TextStyle(
                                                  fontSize: 15,
                                                )),
                                            child: const Text('Ir para o login',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25)),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login(),
                                                  ));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),

                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                  ]),
            ),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        ));
  }
}
