import 'package:flutter/material.dart';

import 'package:gifts_4_you/selecao_de_gostos.dart';
import 'package:gifts_4_you/cadastro.dart';
import 'package:gifts_4_you/tela_inicial.dart';

class Filtro extends StatefulWidget {
  const Filtro({Key? key}) : super(key: key);

  @override
  _FiltroState createState() => _FiltroState();
}

class _FiltroState extends State<Filtro> {
  bool checkedValue = false;
  bool isCheckedPreco = false;
  bool isCheckedVisualizacao = false;
  bool isCheckedOrdemAlfabetica = false;
  Map<String, bool> filtros = {
    "preco": false,
    "visualizacao": false,
    "ordemAlfabetica": false
  };
  List<String> listaFiltros = new List.generate(3, (index) => "");
  _configurandoModalBottomSheet(context){
    return showModalBottomSheet(context: context,builder: (BuildContext bc){
      return StatefulBuilder(builder: (context, setstate){
        return Container(
          height: 400,
          color: //Colors.white,
          Color.fromRGBO(122, 140, 240, 1),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                  'Ordenar por:',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              CheckboxListTile(
                title: Text("Menor preço - Maior preço",style: TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
                checkColor: Colors.white,
                activeColor:Color(0xffb43144),
                //fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isCheckedPreco,
                onChanged: (bool? value) {
                  setstate(() {
                    isCheckedPreco = value!;
                  });
                },

              ),
              CheckboxListTile(
                title: Text("Mais visualizados",style: TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
                checkColor: Colors.white,
                activeColor: Color(0xffb43144),
                //fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isCheckedVisualizacao,
                onChanged: (bool? value) {
                  setstate(() {
                    isCheckedVisualizacao = value!;

                  });
                },

              ),
              CheckboxListTile(
                title: Text("Menor preço - Maior preço",style: TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
                checkColor: Colors.white,
                activeColor: Color(0xffb43144),
                //fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isCheckedOrdemAlfabetica,
                onChanged: (bool? value) {
                  setstate(() {
                    isCheckedOrdemAlfabetica = value!;
                  });
                },

              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffb43144),
                    textStyle: TextStyle(
                      fontSize: 15,
                    )),
                child: const Text('Salvar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20)),
                onPressed: () {
                  this.filtros["preco"] = isCheckedPreco ? true : false;
                  this.filtros["visualizacao"] = isCheckedVisualizacao ? true : false;
                  this.filtros["ordemAlfabetica"] = isCheckedOrdemAlfabetica ? true : false;
                  print(this.filtros);
                  print(this.filtros.length);
                  Navigator.pop(context);

                },
              )
            ],
          ),

        );
      });
    }


    );
  }


  @override
  Widget build(BuildContext context) {

        /* Container(
            child: Wrap(children: <Widget>[
              ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Músicas'),
                  onTap: () => {}
              ),
              ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Videos'),
                onTap: () => { },
              ),
              ListTile(
                leading: new Icon(Icons.satellite),
                title: new Text('Tempo'),
                onTap: () => {},
              ),
            ],
            ),
          );*/

    return new FloatingActionButton(
      backgroundColor:  Color.fromRGBO(122, 140, 240, 1) ,
      onPressed: (){
        _configurandoModalBottomSheet(context);
      },

      child: new Icon(Icons.filter_alt_outlined),
    );
  }
}
