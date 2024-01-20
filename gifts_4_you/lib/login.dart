import 'package:flutter/material.dart';
import 'package:gifts_4_you/db_helper.dart';
import 'package:gifts_4_you/perfil.dart';

import 'package:gifts_4_you/selecao_de_gostos.dart';
import 'package:gifts_4_you/cadastro.dart';
import 'package:gifts_4_you/tela_inicial.dart';
import 'package:gifts_4_you/teste_BD.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText =
      "Ainda não possui uma conta no gifts 4U? Clique aqui e se cadastre!";
  void _resetField() {
    setState(() {
      emailController.text = "";
      passwordController.text = "";
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(65, 65, 65, 1),
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
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                          labelStyle: TextStyle(color: Colors.white)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      controller: passwordController,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) return "Insira sua senha!";
                        }
                      },
                    ),
                    Padding(
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: ()async {
                            if (_formKey.currentState!.validate()) {
                              //emailController.text;
                              //passwordController.text
                              db_helper db = new db_helper();
                              if( await db.checaUsuario(emailController.text, passwordController.text)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TelaInicial( email: emailController.text,),
                                    ));
                              }
                            }
                          },
                          child: Text("Entrar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          color: Color.fromRGBO(122, 140, 240, 1),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Cadastro();
                          }));
                        },
                        child: Text(_infoText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                decoration: TextDecoration.underline))),


                  ]),
            ),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        )
    );
  }
}
