import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gifts_4_you/categoria_automotivo.dart';
import 'package:gifts_4_you/categoria_bebida.dart';
import 'package:gifts_4_you/categoria_cozinha.dart';
import 'package:gifts_4_you/menu_inferior.dart';
import 'package:gifts_4_you/selecao_de_gostos.dart';
import 'package:meta/meta.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TelaInicial extends StatefulWidget {
  @override
  final String email;
  TelaInicial({ required this.email});

  _TelaInicial createState() => _TelaInicial();


  

}

class _TelaInicial extends State<TelaInicial>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        title: BarraDePesquisa(),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
              .stretch, //alarga o máximo que consegue para pegar a largura toda
            children: <Widget>[
              Container(

                 child:
                 GestureDetector(
                   onTap: () { Navigator.push(context,
                       MaterialPageRoute(builder: (context) {
                         return TelaAnalise();
                       }));}, // handle your image tap here
                   child: Image.asset(
                     'assets/images/carrossel1.png',
                     fit: BoxFit.cover, // this is the solution for border
                     width: 300.0,
                     height: 260.0,

                   ),
                 )


              ),
       /* Row(

                  children: <Widget>[
                    Image.asset(
                  'assets/images/carrossel1.png',
                  height: 300,
                  width: 300,
                    ),
                  ]

                )*//*Image.asset(
                  'assets/images/carrossel1.png',
                  height: 300,
                  width: 300,


                ),*/

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () {
                      print("Selecionou categoria 'Automotivo'");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoriaAutomotivo(),
                          ));

                    },
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Automotivo", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                    height: 50,
                    //children: <Widget>[
                    child: FlatButton(
                      onPressed: () { ("Selecionou categoria 'Bebidas'");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoriaBebida(),
                          ));},
                      color: Color.fromRGBO(246, 246, 246, 1),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                      ),
                      child: Text("Bebidas", style: TextStyle(color: Colors.black87, fontSize: 20)),

                    ),

                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () { ("Selecionou categoria 'Cozinha'");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoriaCozinha(),
                        ));},
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Cozinha", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Cuidados pessoais e beleza'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Cuidados pessoais e beleza", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Decoração'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Decoração", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Esporte'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Esporte", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Ferramentas e construção'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Ferramentas e construção", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Filmes e séries'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Filmes e séries", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Jogos e brinquedos'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Jogos e brinquedos", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Livros'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Livros", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Moda'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Moda", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Música'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Música", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Papelaria e escritório'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Papelaria e escritório", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Pets'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Pets", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Tecnologia'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Tecnologia", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),

              Padding(
                child: Container(
                  height: 50,
                  //children: <Widget>[
                  child: FlatButton(
                    onPressed: () => ("Selecionou categoria 'Viagem'"),
                    color: Color.fromRGBO(246, 246, 246, 1),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                    ),
                    child: Text("Viagem", style: TextStyle(color: Colors.black87, fontSize: 20)),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),


            ]
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigation(opcao: 0,email:widget.email),
    );
  }
}

class BarraDePesquisa extends StatefulWidget {
  @override
  _BarraDePesquisa createState() => _BarraDePesquisa();
}

class _BarraDePesquisa extends State<BarraDePesquisa> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose(){
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged(){
    print(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: <Widget>[
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search)
                ),
              )
            ]
        )
    );
  }
}