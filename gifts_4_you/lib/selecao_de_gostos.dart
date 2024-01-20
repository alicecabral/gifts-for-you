import 'dart:core';
import 'dart:core';


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gifts_4_you/Apresentacao_presentes.dart';
import 'package:gifts_4_you/menu_inferior.dart';



class CheckBoxAtributos extends StatefulWidget {

  Map<String,bool> List_atributos = {};
  CheckBoxAtributos({required this.List_atributos});
  _CheckBoxAtributos createState() => new _CheckBoxAtributos();

  List<String> getItems() {

    List<String> aux = [];

    List_atributos.forEach((key, value) {
      if(value ==true )
      aux.add(key);
    });

    return aux;
  }
}

class _CheckBoxAtributos extends State<CheckBoxAtributos>{

  @override
  Widget build(BuildContext context) {
    return(
      Container(
          padding: EdgeInsets.all(20),
          width : MediaQuery. of(context). size. width ,
          height : MediaQuery. of(context). size. height,

      child:Column(
        children: <Widget>[
          Expanded(

              child: ListView(
                children: widget.List_atributos.keys.map((String key){
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(key,style: TextStyle(color: Colors.black,fontFamily: "Roboto",fontSize: 16),),
                    value: widget.List_atributos[key],
                    selectedTileColor: Color.fromRGBO(192, 49, 68, 1),
                    activeColor: Colors.white,

                    checkColor: Color.fromRGBO(192, 49, 68, 1),
                    onChanged:(bool? value) {
                      setState(() {
                        widget.List_atributos[key] = value!;
                      });

                    },
                  );


                }).toList(),
              )
          )
        ],
      )
    )

    );

  }
}

class TelaAnalise extends StatefulWidget{

  @override
  _TelaAnaliseState createState() => _TelaAnaliseState();
}

class _TelaAnaliseState extends State<TelaAnalise> {
  var x = CheckBoxAtributos(List_atributos: {"Automotivo":false,"Bebidas":false,"Cozinha":false,"Cuidados Pessoais e Beleza":false,"Decoração":false,"Esporte":false,"Ferramentas e Construção":false,"Filmes e Séries":false,"Jogos e Brinquedos":false,"Livros":false,"Moda":false,"Música":false, "Papelaria e Escritório":false,"Pets":false,"Tecnologia":false,"Viagem":false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(//Container no lugar
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        appBar: AppBar(


          toolbarHeight: 159,
          leadingWidth: MediaQuery. of(context). size. width,

          flexibleSpace: Image(
            image: AssetImage("assets/images/selecao_interesses.png"),
            fit: BoxFit.cover,
          ),

        ),
        body: Container(
            padding: EdgeInsets.all(20),
            width : MediaQuery. of(context). size. width ,
            height : MediaQuery. of(context). size. height,
            child: Column(
            children: <Widget>[
              Expanded(

              child: ListView(

                children: <Widget>[

                /*Text(
                    'Selecione os interesses da \n pessoa que deseja presentear:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Roboto"
                    ),
                  ),*/
                  x,


                ]
            )
        )
    ],
            )
        ),
        floatingActionButton: Container(
          width: 150,
          height: 70,
          child: ElevatedButton(
            child: Text("Encontrar\npresentes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: (){
              print("pressed");
              print("Items:"+x.getItems().toString());//chamar pagina apresentação presentes

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return apresentacao(preferencias: x.getItems());
                  }));

            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(122, 140, 240, 1)
                //Colors.red,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(

              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),


            ),
          ),
        ),
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: bottomNavigation(opcao: 0),


    );
  }
}
