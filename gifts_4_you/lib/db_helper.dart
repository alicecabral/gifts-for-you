import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:async';

/***
 *  Funções que o arquivo contém
 *
 *  _textToMd5: transforma senha para MD5;
 *  _recuperarBD: retorna o banco de dados aberto;
 *
 *  _checaUsuario: confere se senhas batem; recebe email e senha;retorna bool erro e usuario;
 *  _recuperaUsuario: retorna uma lista de usuários e bool erro;
 *  _adicionaUsuario:recebe dados;retorna bool erro;
 *  _atualizaUsuario: recebe usuario atualizado e insere na tabela;retorna bool erro;
 *  _deletaUsuario
 *
 *  _recuperaProduto_id:recupera produto unico por id
 *  _recuperaProduto: recebe string do nome do produto;Retorna lista de produtos
 *  _recuperaProdutos:recebe string da categoria do produto;Retorna lista de produtos
 *  _adicionaProduto:recebe atributos e adiciona ao bd;
 *  _atualizaProduto:recebe instância ja atualizada e atualiza no bd
 *  _deletaProduto
 *
 *  _recuperaLoja
 *  _adicionaLoja
 *  _atualizaLoja
 *  _deletaLoja
 *
 *  _adicionaFavorito
 *  _recuperaFavorito
 *  _deletaFavorito
 ***/
class db_helper {



  static final db_helper _instance = new db_helper.internal();

  factory db_helper() => _instance;
  db_helper.internal();


  Future<List> Query(String table, String Where, List Args) async{
    /// String table apenas dizendo a tabela a se fazer a query
    /// Where seria a expressão a ser avaliada sem os argumentos.Segue esse formato: "id = ?,nome = ?"
    /// Args seriam os argumentos a serem passados. Devem estar em uma lista e na sequência

    Database bd = await _recuperarBD();
    bool erro = false;
    List l = await bd.query(table, where: Where, whereArgs: Args);
    if (l.isEmpty) {
      print("Busca nao retorna nenhum resultado");
      erro = true;
    } else if (l.length > 1) {
      erro = true;
      print("Busca retorna multiplos resultados");
    }
    return [erro,l];
  }

  Future<List> selectAll(String table,String categoria) async{
    Database bd = await _recuperarBD();
    bool erro = false;
    List l = await bd.query(table,where: "categoria=?",whereArgs: [categoria]);
    if (l.isEmpty) {
      print("Busca nao retorna nenhum resultado");
      erro = true;
    } else if (l.length > 1) {

      print("Busca retorna multiplos resultados");
    }
    return [erro,l];

  }


  Future<bool> Insert(String table,  Map<String, dynamic> data, key, value) async{
    //Key e value servem para o teste de se a instancia ja existe

    bool erro = false;
    List exists = await Query(table,key,value);
    print(exists);
    if (exists[0]) {

      Database bd = await _recuperarBD();
      if(table=='usuario'){
        data['senha'] = _textToMd5(data['senha']);
      }
      int id = await bd.insert(table, data);
      print("Inserido com Sucesso!\n");

    }else{

      print("Erro na inserção, já existe elemento com o ID");
      erro = true;

    }
    return erro;

  }
  Future<int> Update(String table,  Map<String, dynamic> data) async {


        Database bd = await _recuperarBD();
        if(table == 'usuario') {

          List usuarios = await Query(table, "email = ?", [data['email']]);
          List<Map>  usuario= usuarios[1];
          if(_textToMd5(data['senha'])==usuario[0]['senha']) {
            data['senha'] = usuario[0]['senha'];
          }else{
            data['senha'] = _textToMd5(data['senha']);
          }
        }
        int count = await bd.update(table, data);
        if(count < 1) {
          print('Ocorreu algum problema');
        }else{
          print("Update realizado");
        }
        return count;
  }

  Future<bool> Delete(String table,String Where,List Args) async{
    /// String table apenas dizendo a tabela a se fazer a query
    /// Where seria a expressão a ser avaliada sem os argumentos.Segue esse formato: "id = ?"
    /// Args seriam os argumentos a serem passados. Devem estar em uma lista e na sequência
    bool erro = false;
    Database bd = await _recuperarBD();
    int num = await bd.delete(table,
        where:Where,
        whereArgs: Args
    );
    if(num<1 || num >2 ){
      print("Instância nao encontrada ou mais de uma instância excluida");
      erro = true;
    }else{
      print("Excluído com Sucesso");
    }
    return erro;

  }

  Future<int> InsereExemplos() async{
    Database db = await _recuperarBD();
    //print("TESTEEEEE");
   // List<Map<String,dynamic>> lista;
   // String ver = (await db.getVersion().toString());
    //print("Versao: "+ver);
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    await db.delete("produto");

    String sql = """
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Calibrador Medidor De Pressão De Pneus P/carro Moto Bike',36.72,36.72,36.72,'Automotivo','Americanas','Submarino','Shoptime','https://www.americanas.com.br/produto/19098282?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=af9ef7f83f34487089ed975d3d8ecbe4&utm_content=af9ef7f83f34487089ed975d3d8ecbe4','https://www.submarino.com.br/produto/19098282?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=ede61c7ba5be4832a5c444b922f502d8&utm_content=ede61c7ba5be4832a5c444b922f502d8','https://www.shoptime.com.br/produto/19098282?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca:shop%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:9381&utm_source=zoom&utm_medium=comparadores&opn=COMPARADORES&franq=2af2d1029d6d43d9b80ed7c32ca4fe03&utm_content=2af2d1029d6d43d9b80ed7c32ca4fe03','https://a-static.mlcdn.com.br/574x431/calibrador-medidor-de-pressao-de-pneus-p-carro-moto-bike-western/lojadaly/9d3562e654d911eb93464201ac1850d5/cab06c64c89cce5e9079793add9b8509.jpg');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Cabo Chupeta Para Bateria De Carro Com 2,5m',29.69,29.69,29.69,'Automotivo','Americanas','Submarino','Shoptime','https://www.americanas.com.br/produto/429407313?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=a673fa3587c64d7b8b2b9ec9cec9a3d5&utm_content=a673fa3587c64d7b8b2b9ec9cec9a3d5','https://www.submarino.com.br/produto/429407313?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=34ffcea5c4e04f66a7d735a5854874ec&utm_content=34ffcea5c4e04f66a7d735a5854874ec','https://www.submarino.com.br/produto/429407313?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=34ffcea5c4e04f66a7d735a5854874ec&utm_content=34ffcea5c4e04f66a7d735a5854874ec','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMwJPyJmqyeXrdF0uVtDT8m3lCBHUiD780DA&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Protetor Solar Para Carro Parabrisas Quebra Sol Tapa Sol',25.9,29.44,33.72,'Automotivo','Americanas','Casas Bahia','Amazon','https://www.americanas.com.br/produto/2468335252?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=40cbe76ab0c244538d73cc4403e84e10&utm_content=40cbe76ab0c244538d73cc4403e84e10','https://www.casasbahia.com.br/protetor-solar-para-carro-parabrisas-quebra-sol-tapa-sol-1501568279/p/1501568279?c=zoomCPA&cm_mmc=zoom_XML-_-AUTO-_-Comparador-_-1501568279&utm_campaign=f33e53821574410ab3c8c5572b6e5649&utm_medium=comparadorpreco&utm_content=1501568279&utm_source=zoom&pid=zoom_int','https://www.amazon.com.br/dp/B07CQ5NN8L/ref=olp-opf-redir?aod=1&creativeASIN=B07CQ5NN8L&linkCode=asm&tag=zoom059-20&ie=UTF8&condition=new&creative=380345&ascsubtag=8463f62834784996bfa406a1472e1dbc','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmfSivBqLr5zHP2A0q_vKAiltpM1RAwbsaTA&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Suporte Magnético De Celular Para Carros Saída De Ar Philips',25.57,49,25.5,'Automotivo','Submarino','Shoptime','Americanas','https://www.submarino.com.br/produto/3221927168?epar=epar&hl=lower&s_term=COMPARADOSSUB&opn=COMPARADOSSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca:suba%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:zoom&franq=6d2f20d59ca043f0ba31650a8bddc931&utm_content=6d2f20d59ca043f0ba31650a8bddc931','https://www.shoptime.com.br/produto/3327876987?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca:shop%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:9381&utm_source=zoom&utm_medium=comparadores&franq=790af50c42784ef3a36092e1afe1e39e&utm_content=790af50c42784ef3a36092e1afe1e39e','https://www.americanas.com.br/produto/3345926933?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca:acom%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:zoom&utm_medium=comparadores&franq=bf0fbaeb560b487e8c66df4c43181f51&utm_content=bf0fbaeb560b487e8c66df4c43181f51','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSF1293hvp3DBjRYqRKMnE-dh3ke-ARVb_GNovelqDtQPoFLq9Iaw2U91S7HvOP1l-7DxQ&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Alarme Para Carro Universal Positron Cyber Ex360 Exact',255.65,261.15,261.15,'Automotivo','Americanas','Submarino','Shoptime','https://www.americanas.com.br/produto/1876214302?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=b4e1da1ae1f441eeb6df741ee5614785&utm_content=b4e1da1ae1f441eeb6df741ee5614785','https://www.submarino.com.br/produto/1876214302?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=aa93d1bd3b2145fcadb32415846faf90&utm_content=aa93d1bd3b2145fcadb32415846faf90','https://www.shoptime.com.br/produto/1876214302?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca:shop%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:9381&utm_source=zoom&utm_medium=comparadores&opn=COMPARADORES&franq=660389d3894e494ab42cd0dae18df9e4&utm_content=660389d3894e494ab42cd0dae18df9e4','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOiTsMdmFHG5-ZMj67mJr-ekLYBklTvJ6tPjK-_ah2KQixI_2XEUPMCJlwTh7gExjO5aM&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Carregador Veicular Driftin Universal USB',21.73,21.4,22.88,'Automotivo','Americanas','Submarino','Shoptime','https://www.americanas.com.br/produto/120676996?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=ac8021a38b5d4b4684540135648fb219&utm_content=ac8021a38b5d4b4684540135648fb219','https://www.submarino.com.br/produto/120676996?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=8d16b849698342778c73993423d15d2e&utm_content=8d16b849698342778c73993423d15d2e','https://www.shoptime.com.br/produto/120676996?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca:shop%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:9381&utm_source=zoom&utm_medium=comparadores&opn=COMPARADORES&franq=3ebf7c4225d34b7f95e22677f8354c5e&utm_content=3ebf7c4225d34b7f95e22677f8354c5e','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmCAULpKZVoE7FrHapWm-1_DnmrxOnjRIgKRRRnr7SPKGkptmR-J0-5hUOAKS25JU946c&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Aparelho De Som Carro Automotivo Bluetooth Pendrive Rádio Sd',90.6,167.4,180,'Automotivo','AliExpress','Shoptime','Casas Bahia','https://pt.aliexpress.com/item/1005003213868725.html?isdl=y&aff_fsk=_9ywL0t&src=ZOOM&aff_platform=true&aff_short_key=_9ywL0t&dp=79612cd2d10b49af80f906ac790aebb3','https://www.shoptime.com.br/produto/3794320275?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca:shop%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:9381&utm_source=zoom&utm_medium=comparadores&franq=8b4009f83d124f888d57faf3b9ff9d34&utm_content=8b4009f83d124f888d57faf3b9ff9d34','https://www.casasbahia.com.br/aparelho-de-som-carro-automotivo-bluetooth-pendrive-sd-radio-1519931116/p/1519931116?utm_content=1519931116&utm_campaign=72a77ce7b1e647a89e79b59da5a75c38&c=zoomCPA&utm_source=zoom&pid=zoom_int&utm_medium=comparadorpreco&cm_mmc=zoom_XML-_-AUTO-_-Comparador-_-1519931116','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjVlg_lODepPFkRRAIJmQKn9IFn0EwfsR-n8xm3zWUu4cm-i5xVUvNajzmuUPuXOWLlb8&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Água Mineral Voss Sem Gás 500ml Garrafa Plástico',31.8,28.62,27.16,'Bebidas','Americanas','Submarino','Magazine Luiza','https://www.americanas.com.br/produto/1214431818?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=edccae42c00848dcbb75f2a14047d8be&utm_content=edccae42c00848dcbb75f2a14047d8be','https://www.submarino.com.br/produto/1214431818?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=0bf922cd88bc4671945fa889251b15b8&utm_content=0bf922cd88bc4671945fa889251b15b8','https://www.magazineluiza.com.br/agua-mineral-voss-sem-gas-500ml-garrafa-plastico/p/cb8a3gd559/me/agum/?&=&seller_id=villenibebidas&utm_source=zoom&utm_medium=cpa&utm_campaign=-ft_none-nc_comparadores-oc_venda&utm_content=-un_magalu-ce_b2c-cp&partner_id=10569&utm_term=1cf947427435460b804a992d267fe433','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5uH6EN2Xjnw7F82kYTtXKph5wu7kVB0uZEg&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Energético Monster Mango Loco - 473ml',4.99,10.8,10.8,'Bebidas','Amazon','Submarino','Americanas','https://www.amazon.com.br/dp/B07Y2F7F8T/ref=asc_df_B07Y2F7F8T1637848800000/?tag=zoom1p-20&creative=380333&creativeASIN=B07Y2F7F8T&linkCode=asn&ascsubtag=0a56881502854a14a6a8c7f36b73b002','submarino.com.br/produto/1466880901?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=a7e19cd0953440849ba822698f6f5275&utm_content=a7e19cd0953440849ba822698f6f5275','https://www.americanas.com.br/produto/1466880901?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=a41ca52a3f8a43dabc6dc75aa776b4a2&utm_content=a41ca52a3f8a43dabc6dc75aa776b4a2','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKalkwF-WkJgP9Ws5Ac886nkcECS_JBaa9UQ&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Refrigerante Coca Cola Pet 2 Litros',7.99,7.99,7.99,'Bebidas','Submarino','Ponto Frio','Casas Bahia','https://www.submarino.com.br/produto/2811355948?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=231c933419d34b74a72fba2add01a97d&utm_content=231c933419d34b74a72fba2add01a97d','https://www.pontofrio.com.br/refrigerante-coca-cola-pet-2-litros-1505930927/p/1505930927?utm_content=1505930927&utm_medium=comparadorpreco&pid=zoom_int&c=zoomCPA&utm_source=zoom&cm_mmc=zoom_XML-_-BEBI-_-Comparador-_-1505930927&utm_campaign=562b5520f4b4496094dc138f5c33bc9a','https://www.casasbahia.com.br/refrigerante-coca-cola-pet-2-litros-1505930927/p/1505930927?pid=zoom_int&c=zoomCPA&utm_source=zoom&cm_mmc=zoom_XML-_-BEBI-_-Comparador-_-1505930927&utm_content=1505930927&utm_campaign=f13bc37e3dd548288ff2d084d52e782b&utm_medium=comparadorpreco','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0TMwDglxJCt_4SlYQkcHIhrDVvaum3NmyJg&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Suco de Uva Integral Tinto Vidro Aurora 500ml',32.53,32.53,32.39,'Bebidas','Submarino','Americanas','Magazine Luiza','https://www.submarino.com.br/produto/3663047539?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=f779b713597a41b78f51685d12e4ee96&utm_content=f779b713597a41b78f51685d12e4ee96','https://www.americanas.com.br/produto/3663047539?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=22d4c31591fb4ce5beb60a06cef85b71&utm_content=22d4c31591fb4ce5beb60a06cef85b71','https://www.magazineluiza.com.br/suco-de-uva-aurora-integral-sem-adicao-500ml/p/ghfkj8a38a/me/bbid/?&=&seller_id=webglamour&utm_source=zoom&utm_medium=cpa&utm_campaign=-ft_none-nc_comparadores-oc_venda&utm_content=-un_magalu-ce_b2c-cp&partner_id=10569&utm_term=8636b00e307041baaa056e72b4b9e82e','https://www.vinicolaaurora.com.br/images/sucodeuva/produtos/suco-300ml.png');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Vinho Pérgola Tinto Suave 1 L - Nacional',21.22,24.39,24.39,'Bebidas','Casas Bahia','Americanas','Submarino','https://www.casasbahia.com.br/vinho-pergola-tinto-suave-1-l-nacional-1500193389/p/1500193389?utm_source=zoom&cm_mmc=zoom_XML-_-BEBI-_-Comparador-_-1500193389&pid=zoom_int&c=zoomCPA&utm_campaign=fc20c1ee31d9494bbce9ff9ba9c48f19&utm_medium=comparadorpreco&utm_content=1500193389','https://www.americanas.com.br/produto/2469987341?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=cfde0f42b74f464c8e9f646321ccb944&utm_content=cfde0f42b74f464c8e9f646321ccb944','https://www.submarino.com.br/produto/2469987341?epar=epar&hl=lower&s_term=COMPARADOSSUB&opn=COMPARADOSSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=0a68df9502bc426e946130a022b741e7&utm_content=0a68df9502bc426e946130a022b741e7','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIxYWRVKITwi-BI2ndQBUnevrwDn9rNpj-CQ&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Cerveja Heineken 600ml Premium Lager - Caixa com 12 Garrafas',111.5,119.9,119.9,'Bebidas','Shoptime','Americanas','Submarino','https://www.shoptime.com.br/produto/60383113?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca:shop%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:9381&utm_source=zoom&utm_medium=comparadores&opn=COMPARADORES&franq=154a37e96fc54be1a3a490369caa3458&utm_content=154a37e96fc54be1a3a490369caa3458','https://www.americanas.com.br/produto/60383113?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=e1b63135b6df494199126e6613dcd661&utm_content=e1b63135b6df494199126e6613dcd661','https://www.submarino.com.br/produto/60383113?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=863fec699cbc4cd0afec32d6bd90a0aa&utm_content=863fec699cbc4cd0afec32d6bd90a0aa','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaMcnviqhdw704Qgrhb4nAULJcSjgyi174pw&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Água de Coco Kero Coco 1L',10.99,10.99,8.49,'Bebidas','Submarino','Americanas','Amazon','https://www.submarino.com.br/produto/20173413?s_term=COMPARADORESSUB&opn=COMPARADORESSUB&epar=zoom&hl=lower&utm_medium=comparadores&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_source=zoom&loja=33744258000151&franq=cabfa1c17adf49fa87eab666f1ce04e6&utm_content=cabfa1c17adf49fa87eab666f1ce04e6','https://www.americanas.com.br/produto/20173413?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=95e048bbae824fb4a28975e76a5bd79f&utm_content=95e048bbae824fb4a28975e76a5bd79f','https://www.amazon.com.br/dp/B00KFU627K/ref=asc_df_B00KFU627K1637848800000/?linkCode=asn&creative=380333&creativeASIN=B00KFU627K&tag=zoom1p-20&ascsubtag=01b97c78ec9b4e1293d8e6a2139e34c5&th=1','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrg__69yJAnTAGslt6ti5pII8KQnfw0llY1IxQYkW6-AJDbw1nHIcBqpnLNItN2BOgNZc&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Conjunto de Panelas Tramontina Aço Inox 6 peça(s) Solar',586.43,699,543.99,'Cozinha','Amazon','Magazine Luiza','Americanas','https://www.amazon.com.br/dp/B076B9N81Q/ref=asc_df_B076B9N81Q1637679600000/?tag=zoom1p-20&creativeASIN=B076B9N81Q&linkCode=asn&creative=380333&ascsubtag=086fd3a054034291842d06ce46ea5067','https://www.magazineluiza.com.br/jogo-de-panelas-tramontina-solar-fundo-triplo-aco-inox-6-pecas/p/khkkb33bcg/ud/cjpn/?&=&seller_id=efacil&utm_source=zoom&utm_medium=cpa&utm_campaign=-ft_none-nc_comparadores-oc_venda&utm_content=-un_magalu-ce_b2c-cp&partner_id=10569&utm_term=6963e32c75c043dbba5440328042650c','https://www.americanas.com.br/produto/7403898?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=4602eee905a2417cac1f6e4b7eb399fd&utm_content=4602eee905a2417cac1f6e4b7eb399fd','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMOSwvSAeSjzZ76ZRM0U8SxWagYHr-toC2LQ&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Faqueiro Tramontina Faca De Churrasco Inox 72 Peças Italy',851.9,1035.36,851.9,'Cozinha','Americanas','Carrefour','Submarino','https://www.americanas.com.br/produto/2896623242?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=58892b9c03074acab479e3bd346bd3fc&utm_content=58892b9c03074acab479e3bd346bd3fc','https://www.carrefour.com.br/faqueiro-tramontina-faca-de-churrasco-inox-72-pecas-italy-mp911673855/p?utm_source=zoom_buscape_3p&utm_medium=comp&=&utm_campaign=zoom_buscape_3p&bigclid=eyJvZmZlcklkIjoxMDA5ODUxMjUsInNrdSI6IjEwNjM0MDE1IiwiZ3JvdXBJZCI6IjEwNjM0MDE1IiwibG9nIjoiMjUvMTEvMjAyMSAxMjoxNiJ9&utm_content=8af52c1919004442a08c2b62a0b424ca','https://www.submarino.com.br/produto/2896623242?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=15b1263c2bfb4fc18af0fe47dadd39fa&utm_content=15b1263c2bfb4fc18af0fe47dadd39fa','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu1DDCS8mTpi-Hv0ZP1gHd2tUs4Ez-0ut9SmK12rFmWwmpr_XXz3sg6KfUe9heU9vzxw4&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Jogo de Xícaras de Café 6 Peças com Suporte Coloridas - Bon Gourmet',56,48.93,56,'Cozinha','Americanas','Magazine Luiza','Submarino','https://www.americanas.com.br/produto/133790000?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=5189d2f9267b43e18cfe9688e32c6f1e&utm_content=5189d2f9267b43e18cfe9688e32c6f1e','https://www.magazineluiza.com.br/jogo-de-xicaras-de-cafe-6-pecas-com-suporte-coloridas-bon-gourmet/p/jfhge4gb6k/ud/udas/?&=&seller_id=gahe&utm_source=zoom&utm_medium=cpa&utm_campaign=-ft_none-nc_comparadores-oc_venda&utm_content=-un_magalu-ce_b2c-cp&partner_id=10569&utm_term=3f8970993b7c4ea8a44f3b736fca590e','https://www.submarino.com.br/produto/133790000?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=d312b1d9e5044bc7b6d589db37bd460d&utm_content=d312b1d9e5044bc7b6d589db37bd460d','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHD-0eaWd7tFU2pJRcWnN6glMWqhAVDad1Ow&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Conjunto De Pratos Schimidt Sobremesa De Porcelana Prisma 6 Peças',57.96,57.96,69,'Cozinha','Americanas','Submarino','Magazine Luiza','https://www.americanas.com.br/produto/78432102?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=ba7e2a8406a944b693e79f1640508612&utm_content=ba7e2a8406a944b693e79f1640508612','https://www.submarino.com.br/produto/78432102?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=979ed5a38cb149ddb2332a62a4b6f10a&utm_content=979ed5a38cb149ddb2332a62a4b6f10a','https://www.magazineluiza.com.br/conjunto-de-pratos-sobremesa-schmidt-porcelana-prisma-6-pecas/p/ehg1g11hc9/ud/pras/?&=&seller_id=efacil&utm_source=zoom&utm_medium=cpa&utm_campaign=-ft_none-nc_comparadores-oc_venda&utm_content=-un_magalu-ce_b2c-cp&partner_id=10569&utm_term=747b97bc83f645938d54f90a9026f998','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc5fZ-V1jlWzUTQd5iOq84Tucamiiu6ao8Vw&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Panela de Pressão Elétrica 6 Litros - Electrolux PCC20',499.99,438.24,399,'Cozinha','Amazon','Casas Bahia','Magazine Luiza','https://www.amazon.com.br/dp/B076HSQQ18/ref=asc_df_B076HSQQ181637679600000/?tag=zoom1p-20&creativeASIN=B076HSQQ18&linkCode=asn&creative=380333&ascsubtag=0745a038dd1a4d08af78957d1d469e6c&th=1','https://www.casasbahia.com.br/panela-de-pressao-eletrica-electrolux-6-litros-15-receitas-pre-programadas-inox-pcc20-220-volts-1511794323/p/1511794323?pid=zoom_int&utm_content=1511794323&utm_medium=comparadorpreco&cm_mmc=zoom02_XML-_-ELPO-_-Comparador-_-1511794323&c=zoomCPC&utm_campaign=b29cc3e206ac489fbbcfeac9f8266d6f&utm_source=zoom02','https://www.magazineluiza.com.br/panela-de-pressao-eletrica-electrolux-digital-pcc20-1000w-controle-de-temperatura/p/023301500/ep/pael/?&=&seller_id=magazineluiza&utm_source=zoom&utm_medium=cpc&utm_campaign=-ft_none-nc_comparadores-oc_venda&utm_content=-un_magalu-ce_b2c-cp&partner_id=62174&bigclid=eyJvZmZlcklkIjoxMjMyODc3NTcsInNrdSI6IjAyMzMwMTUiLCJncm91cElkIjoiMDIzMzAxNSIsImxvZyI6IjI1LzExLzIwMjEgMDc6NDUifQ&utm_term=485fd88240014b0ca50a1021c3e01497','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqqeoIcoG2YS-O3JY1ZQLY9baJSJO6e07Yeg&usqp=CAU');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Kit Confeiteiro Bruninha Formas, Bailarina 40cm, Bicos',227.03,237.35,227.03,'Cozinha','Americanas','Shoptime','Submarino','https://www.americanas.com.br/produto/1519437831?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=052e47ab5ef54b338c88db061a1c8ae8&utm_content=052e47ab5ef54b338c88db061a1c8ae8','https://www.shoptime.com.br/produto/1519437831?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca:shop%3Bmidia:comparadores%3Bformato:00%3Bsubformato:00%3Bidcampanha:9381&utm_source=zoom&utm_medium=comparadores&opn=COMPARADORES&franq=2986755ccb10455993f65fec6efe8b56&utm_content=2986755ccb10455993f65fec6efe8b56','https://www.submarino.com.br/produto/1519437831?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=6edf4e816b4e494ba2b3d4bbffe5be7b&utm_content=6edf4e816b4e494ba2b3d4bbffe5be7b','https://images-americanas.b2w.io/produtos/01/00/img/1519437/8/1519437858_1GG.jpg');
INSERT INTO produto (nome,preco_1,preco_2,preco_3,categoria,loja_1,loja_2,loja_3,link_loja_1,link_loja_2,link_loja_3,link_imagem) VALUES('Kit Potes de Vidro Porta Mantimentos Herméticos 4 Unid Electrolux',87.91,91.9,87.91,'Cozinha','Americanas','Shoptime','Submarino','https://www.americanas.com.br/produto/1556610040?epar=ZOOM&opn=YSMESP&hl=lower&utm_source=zoom&s_term=YYNKZU&utm_campaign=marca%3Aacom%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&utm_medium=comparadores&franq=ec2a11ec804a46b08db862132b298f17&utm_content=ec2a11ec804a46b08db862132b298f17&voltagem=N%C3%A3o%20se%20aplica','https://www.shoptime.com.br/produto/1556610040?epar=9381&s_term=COMPARADORES&hl=lower&utm_campaign=marca%3Ashop%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3A9381&utm_source=zoom&utm_medium=comparadores&opn=COMPARADORES&franq=d1fe799e99ee4cb28b915708a570d7cd&utm_content=d1fe799e99ee4cb28b915708a570d7cd&voltagem=N%C3%A3o%20se%20aplica','https://www.submarino.com.br/produto/1556610040?epar=zoom&hl=lower&s_term=COMPARADORESSUB&opn=COMPARADORESSUB&utm_medium=comparadores&utm_source=zoom&utm_campaign=marca%3Asuba%3Bmidia%3Acomparadores%3Bformato%3A00%3Bsubformato%3A00%3Bidcampanha%3Azoom&franq=7648a0f427fe40d0bcb0bccffa9256af&utm_content=7648a0f427fe40d0bcb0bccffa9256af&voltagem=N%C3%A3o%20se%20aplica','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqhSxp1P7xlQWh8JiAdokM3MA_UMUGA2KE3w&usqp=CAU');
""";
    List<String> executar = sql.split(";");

    for(String comando in executar){
      if(comando!="") {
        print(comando);
        await db.rawInsert(comando);
      }
    }

     //await db.rawInsert(sql);
      return 0;



  }
  Future<bool> checaUsuario(email, senha) async {

    List<dynamic> usuarios = await Query("usuario","email = ?",[email]);
    bool isUser = false;
    List<Map> data = usuarios[1];

    print(data[0]['nome']);



      print("checando usuario");
      print(_textToMd5(senha) + " X " + data[0]['senha']);
      if (data[0]['senha'] == _textToMd5(senha)) {

      print("Usuario aceito");
      isUser = true;
    }


    return isUser;

  }



  Future<Database> _recuperarBD() async {
    final dbPath = await getDatabasesPath();
    final local = join(dbPath, "Database5.db");

      Database db = await openDatabase(local, version: 3, onCreate: (db, version) {
        String usuario = '''
        CREATE TABLE usuario (
         id integer primary key autoincrement,
         nome text not null,
         email text not null,
         senha text not null
         );''';
        db.execute(usuario);
         String loja =  """
         CREATE TABLE loja(
         id integer primary key autoincrement,
         nome text not null,
         site text not null
         );
         """;
        db.execute(loja);
        String produto = """
         CREATE TABLE produto(
         id integer primary key autoincrement,
         nome text not null,
         preco_1 real not null,
         preco_2 real not null,
         preco_3 real not null,
         categoria text not null,
         loja_1 text not null,
         loja_2 text not null,
         loja_3 text not null,
         link_loja_1 text not null,
         link_loja_2 text not null,
         link_loja_3 text not null,
         link_imagem text
         ); """;
        db.execute(produto);
         String favorito = """
         CREATE TABLE favorito(
         id integer primary key autoincrement,
         idUsuario integer not null,
         idProduto integer not null,
         FOREIGN KEY(idUsuario) REFERENCES Usuarios(id),
         FOREIGN KEY(idProduto) REFERENCES Produtos(id)
         );""";
         db.execute(favorito);


      });

    return db;
  }

  String _textToMd5(String text) {
    return md5.convert(utf8.encode("concat" + text)).toString();

  }





}
