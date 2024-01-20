import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gifts_4_you/login.dart';
import 'package:gifts_4_you/menu_inferior.dart';

class TelaPerfil extends StatefulWidget {
  @override
  String email = "";

  TelaPerfil({required this.email});

  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      body: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/ImagemPerfil.png',
                  height: 50,
                  width: 50,
                ),
                width: 100,
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'USUÁRIO:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontSize: 27, fontFamily: "Roboto"),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Roboto"),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: 237.73,
                height: 85.38,
                child: ElevatedButton(
                  child: Text(
                    "SAIR DA CONTA",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                    print("sair da conta");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(122, 140, 240, 1)
                        //Colors.red,
                        ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Sobre esta versão',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: "Roboto"),
                      ),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Versão 1.0 Gifts 4U \n Criada por Alice Cabral, Ana Carolina Manso, João Victor Amorim e Juliana Silvestre \n Pontifícia Universidade Católica de Minas Gerais',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: "Roboto"),
                      ),
                    ]),
              )
            ],
          )),
      bottomNavigationBar: bottomNavigation(opcao: 2,),
    );
  }
}
