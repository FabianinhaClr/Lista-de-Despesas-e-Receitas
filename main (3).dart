import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: TelaInicial(), debugShowCheckedModeBanner: false));
}

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<ItemValor> listaintens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("clara 3f"),
          bottom: PreferredSize(
              child: Text(
                "R\$ 0,00",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              preferredSize: Size(100, 10)),
          actions: [
            Container(
              child: const Icon(Icons.add),
              margin: const EdgeInsets.fromLTRB(1.0, 0.0, 10, 0.0),
            ),
          ]),
      body: ListView.builder(
        itemCount: listaintens.length,
        itemBuilder: (context, index) {
          return listaintens[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Formulario(),
              )).then((novoItem) {
            setState(() {
              listaintens.add(novoItem);
            });
          });
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemValor extends StatelessWidget {
  late String tipo;
  late String valor;

  ItemValor({
    required this.tipo,
    required this.valor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cor = Colors.green;
    if (this.tipo == "Despesa") {
      cor = Colors.red;
    }
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on, color: cor),
      title: Text(this.tipo),
      tileColor: Color.fromARGB(255, 212, 216, 201),
      subtitle: Text("R\$ " + this.valor),
      trailing: Icon(Icons.delete),
    ));
  }
}

class Formulario extends StatefulWidget {
  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String controleRadio = "Despesa";
  TextEditingController controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Formulário de Cadastro')),
        body: ListView(children: [
          ListTile(
              leading: Radio(
                value: "Receita",
                groupValue: controleRadio,
                onChanged: (value) {
                  setState(() {
                    controleRadio = value!;
                  });
                  controleRadio = value!;
                },
              ),
              title: Text("Receita")),
          ListTile(
              leading: Radio(
                value: "Despesa",
                groupValue: controleRadio,
                onChanged: (value) {
                  setState(() {
                    controleRadio = value!;
                  });
                  controleRadio = value!;
                },
              ),
              title: Text("Despesa")),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: controllerValor,
              decoration: InputDecoration(hintText: "Insira o valor"),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Valor do radiobuttom: $controleRadio");
                    debugPrint("Valor do textfild: $controllerValor");

                    ItemValor conteudo = ItemValor(
                      tipo: controleRadio,
                      valor: controllerValor.text,
                    );
                    Navigator.pop(context, conteudo);
                  },
                  child: const Text("Salvar")))
        ]));
  }
}
