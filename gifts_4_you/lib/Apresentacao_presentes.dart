import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gifts_4_you/db_helper.dart';

import 'Card_personalizado.dart';
import 'menu_inferior.dart';

class apresentacao extends StatefulWidget{
  List<dynamic> preferencias;
  @override
  apresentacao({required this.preferencias,});
  State<StatefulWidget> createState() => _apresentacao();

}

class _apresentacao extends State<apresentacao>{

  Future<List<dynamic>>Requests() async{
    db_helper db = await db_helper();
    late List<dynamic> produtos = [];
     widget.preferencias.forEach((element) async{
       List<dynamic>x = await db.selectAll("produto", element.toString());
      produtos.addAll(x[1]);
    });
    print(produtos);
    return produtos;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(//Container no lugar
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
    appBar: AppBar(


    toolbarHeight: 159,
    leadingWidth: MediaQuery. of(context). size. width,

    flexibleSpace: Image(
    image: AssetImage("assets/images/sugestao_presentes.png"),
    fit: BoxFit.cover,
    ),

    ),
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
                        future: Requests(),
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
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),),
    ),
        bottomNavigationBar:bottomNavigation(opcao: 0));
  }

}