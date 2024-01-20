import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gifts_4_you/db_helper.dart';
import 'package:gifts_4_you/menu_inferior.dart';
import 'package:gifts_4_you/selecao_de_gostos.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'Card_personalizado.dart';
import 'filtro.dart';

class CategoriaAutomotivo extends StatefulWidget {
  @override
  createState() => _CategoriaAutomotivo();
}

class _CategoriaAutomotivo extends State<CategoriaAutomotivo> {
  Future<List<dynamic>> lista_produtos() async {
    db_helper db = new db_helper();
    List<dynamic> produtos = await db.selectAll("produto",'Automotivo');
    if (produtos[0]) {
      print("Erro na query dos produtos");
    } else {
      print("deu certo");
      print(produtos[1]);
    }
    return produtos[1];
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
          toolbarHeight: 159,
          leadingWidth: MediaQuery.of(context).size.width,

          /*flexibleSpace: Image(
            image: NetworkImage("assets/images/encontrar_presente_ideal.png"), //ALTERAR
            //fit: BoxFit.cover,
          ),*/
          flexibleSpace: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TelaAnalise();
              }));
            }, // handle your image tap here
            child: Image.asset(
              'assets/images/categoria_automotivo.png',
              fit: BoxFit.cover, // this is the solution for border
              width: 300.0,
              height: 300.0,
            ),
          )),
      body: Container(
        child: SingleChildScrollView(
            child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //alarga o máximo que consegue para pegar a largura toda
              children: <Widget>[
                Padding(
                  child: Container(
                    color: Color(0xfff6f6f6),
                    child: FutureBuilder(
                        future: lista_produtos(),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, indice) {
                                  return Card_pers(propriedades:snapshot.data![indice] ,);

                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          ;
                        }),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                )
              ]),

        ),
          padding: EdgeInsets.fromLTRB(0, 10 , 0 ,10 ),),
      ),
      floatingActionButton: new Filtro(),
      bottomNavigationBar: bottomNavigation(
        opcao: 0,
      ),
    );
  }
}
