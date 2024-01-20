

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Card_pers extends StatefulWidget{

  Map<String,dynamic> propriedades;

  Card_pers({required this.propriedades,});

  @override
  createState() => _Card();




}

class _Card extends State<Card_pers> {

  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(

        child:FlatButton(onPressed: (){print("oi");},
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
          ),
          child: Padding(padding:EdgeInsets.fromLTRB(0, 10 , 0 ,10 ),child:Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 0 , 12 ,0 ),child:Image.network(
              widget.propriedades['link_imagem'],
              fit: BoxFit
                  .cover, // this is the solution for border
              width: 100.0,
              height: 100.0,
            ),),
            Expanded(child:Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Padding(padding: EdgeInsets.fromLTRB(0, 0 , 0,6 ),child:Text(widget.propriedades['nome'],
                    overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xffb43144),
                    fontSize: 20,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                ))),
                Padding(padding: EdgeInsets.fromLTRB(0, 0 , 0 ,6 ),child:Text(widget.propriedades['loja_1'] + ", " + widget.propriedades['loja_2'] +", " + widget.propriedades['loja_3']+"      "
                ,style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),)),
                Text("Ofertas por: R\$" +
                    widget.propriedades['preco_1'].toString() + ", R\$" +
                    widget.propriedades['preco_2'].toString() + ", R\$" +
                    widget.propriedades['preco_3'].toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0 , 0 ,0 ),child:SizedBox(
                    width: 250,
                    height: 38,
                    child: CheckboxListTile(
                      title: Text(
                          "Adicionar aos favoritos",
                          style: TextStyle(
                              color:
                              Color(0xffb43144),
                              fontSize: 14)),
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue =
                          !checkedValue;
                        });
                      },
                      controlAffinity:
                      ListTileControlAffinity
                          .leading, // <-- leading Checkbox
                    ))),
              ]

              ,

            ))

            ,

          ]

          ,

        ),
          )
        ),
      padding: EdgeInsets.fromLTRB(0, 7 , 0 ,7 ),
    );
  }
}








