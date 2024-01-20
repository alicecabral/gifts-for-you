import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gifts_4_you/menu_inferior.dart';
import 'package:gifts_4_you/selecao_de_gostos.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PresentesSugeridos extends StatefulWidget {
  @override
  _PresentesSugeridos  createState() => _PresentesSugeridos ();
}

class _PresentesSugeridos  extends State<PresentesSugeridos >{
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        toolbarHeight: 159,
        leadingWidth: MediaQuery. of(context). size. width,

        flexibleSpace: Image(
          image: NetworkImage("assets/images/sugestao_presentes.png"), //ALTERAR
          fit: BoxFit.cover,
        ),
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
                    )
                ),
                Padding(
                  child: Container(
                    width: 414,
                    height: 150,
                    color: Color(0xfff6f6f6),
                    child: FlatButton(
                      onPressed: () => ("oi"),
                      color: Color.fromRGBO(246, 246, 246, 1),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color.fromRGBO(122, 140, 240, 1))
                      ),
                      child: Stack(
                        children:[
                          Positioned(
                            left: 19,
                            top: 19,
                            child: Container(
                              width: 106,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffc4c4c4),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 147,
                            top: 20,
                            child: SizedBox(
                              width: 184,
                              height: 38,
                              child: Text(
                                "Presente 1",
                                style: TextStyle(
                                  color: Color(0xffb43144),
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 147,
                            top: 50,
                            child: SizedBox(
                              width: 184,
                              height: 30,
                              child: Text(
                                "Loja",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 147,
                            top: 80,
                            child: SizedBox(
                              width: 229,
                              height: 38,
                              child: Text(
                                "RXX - RXX",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 125,
                            top: 90,
                            child: SizedBox(
                                width: 280,
                                height: 38,
                                child: CheckboxListTile(
                                  title: Text("Adicionar aos favoritos", style: TextStyle(color: Color(
                                      0xffb43144), fontSize: 14)),
                                  value: checkedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = !checkedValue;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading, // <-- leading Checkbox
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
              ]
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigation(opcao: 0,),
    );
  }
}
