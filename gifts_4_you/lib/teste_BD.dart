import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gifts_4_you/db_helper.dart';

class teste_BD extends StatefulWidget {
  @override
  _teste_BD createState() => _teste_BD();
}

class Usuario {
  int id = 0;
  String nome = "";
  String email = "";
  String senha = "";
}

class _teste_BD extends State<teste_BD> {


  static db_helper _db = new db_helper();
  TextEditingController emailController = TextEditingController();
  TextEditingController novoEmailController = TextEditingController();
  TextEditingController novoNomeController = TextEditingController();
  TextEditingController novaSenhaController = TextEditingController();
  final usuario = new Usuario() ;



  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
        title: const Text('Banco de dados - Gifts 4 U'),backgroundColor: Color(0xffb43144),
    ),
    body:SingleChildScrollView(
    child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize:MainAxisSize.max,
          children: <Widget>[
            /*ElevatedButton(
                child: Text("teste"),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(122, 140, 240, 1),
                ),
                onPressed: () async {
                  Map<String, dynamic> user = {
                    "nome": "Joana",
                    "senha": "123",
                    "email": "joana@gmail.com"
                  };
>>>>>>> 8beafe47a73f040ae825adcc6e169ace95e45bf3

                  await _db.Insert("usuario", user, "email=?", [user['email']]);
                  List resultado =
                      await _db.Query("usuario", "email=?", [user['email']]);
                  print("=========");
                  print(resultado);
                  _db.checaUsuario(user['email'], user['senha']);

                  //user['nome'] = "teste2";
                  //  _db.Update("usuario", user);
                  //_db.Delete("usuario", 'email=?', [user['email']]);
                  //resultado = await _db.Query("usuario", "email=?", [user['email']]);
                }),*/
            ElevatedButton(
                onPressed:() async{
                  await _db.InsereExemplos();

                  List listaTodos = await _db.selectAll('produto','automotivo');
                  print(listaTodos[1].length);
                  print("length"+  listaTodos.length.toString());
                  //print(listaTodos[1][1]['nome']);

                    //print(listaTodos[0]
                    //print("id: " + listaTodos[1][i]['id'].toString() + " - nome: "+ listaTodos[1][i]['nome'] + " - email: " + listaTodos[1][i]['email']);


                  print(listaTodos[1]);

                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(122, 140, 240, 1),
                ),
                child: Text("listar todos os produtos") ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black12, fontSize: 20),
              controller: emailController,


            ),

            ElevatedButton(
                onPressed:() async{

                  try {
                    print(emailController.text);
                    List list = await _db.Query("usuario", "email=?", [emailController.text]);
                    this.usuario.id = list[1][0]['id'];
                    print("id: " + list[1][0]['id'].toString() + " - nome: " +
                        list[1][0]['nome'] + " - email: " +
                        list[1][0]['email']);
                  }catch(error){
                    print("não foram encontrados registros com esse email");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(122, 140, 240, 1),
                ),
                child: Text("Pesquisar um usuário pelo email") ),
            ElevatedButton(
                onPressed:() async{

                  try {
                    var deletou = _db.Delete("usuario", 'email=?', [emailController.text]);

                  }catch(error){
                    print("não foram encontrados registros com esse email");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(122, 140, 240, 1),
                ),
                child: Text("Deletar usuário com o email informado") ),
            Text("Alterar o usuário de email informado (favor pesquisar por ele primeiro)",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)) ,


            TextFormField(
              keyboardType: TextInputType.text,

              decoration: InputDecoration(
                  labelText:"Novo nome" ,
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black12, fontSize: 20),
              controller: novoNomeController,


            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Novo email",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black12, fontSize: 20),
              controller: novoEmailController,


            ),

            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Nova Senha",
                  labelStyle: TextStyle(color: Colors.black)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black12, fontSize: 20),
              controller: novaSenhaController,


            ),
            
            ElevatedButton(
                onPressed:() async{

                  try {
                    Map<String, dynamic> user = {
                      "nome":  novoNomeController.text,
                      "senha":  novaSenhaController.text,
                      "email":  novoEmailController.text
                    };


                    _db.Update("usuario",user );


                  }catch(error){
                    print("não foram encontrados registros com esse email");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(122, 140, 240, 1),
                ),

                child: Text("Alterar usuário do email informado") ),



            /**/

          ],
        )
    ),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),)
    );
  }
}
