import 'package:flutter/material.dart';
import 'package:gifts_4_you/login.dart';
import 'package:gifts_4_you/perfil.dart';
import 'package:gifts_4_you/selecao_de_gostos.dart';
import 'package:gifts_4_you/tela_inicial.dart';

class bottomNavigation extends StatefulWidget{
  @override
  int opcao = 0;
  String email = "";
  bottomNavigation({required this.opcao,this.email = ""});
  _bottomNavigation createState() => _bottomNavigation();
}

class _bottomNavigation extends State<bottomNavigation>{

  int _indiceAtual = 0 ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    final List<Widget> _telas =<Widget> [
      TelaInicial(email: email,),
      Login(),
      TelaPerfil(email:email),
      // Home("Início"),
      // Perfil("Meu Perfil"),
      // Saldo("Minha Conta"),
      // Mapa("Meu Mapa")
    ];


    void onTabTapped(int index) {

      setState(() {
        _indiceAtual = index;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return _telas[index];
            }));
      });
    }


    int _opcao = widget.opcao;
    return(
      BottomNavigationBar(
        backgroundColor: Color.fromRGBO(239, 89, 89, 1),
        currentIndex: _opcao,
        unselectedItemColor: Color.fromRGBO(65, 65, 65, 1),
        selectedItemColor: Colors.white,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Início",
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Favoritos",
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Perfil",
              backgroundColor: Colors.white,


          ),
        ],

      )
    );
  }

}

