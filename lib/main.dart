import 'package:flutter/material.dart';

void main() =>  runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),

      ),
    );
  }
}


class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  //const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criando Transferencia"),),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorNumeroConta,
              style: const TextStyle(
                fontSize: 24
              ),
              decoration: const InputDecoration(
                labelText: 'Numero da conta',
                hintText: '0000'
              ),
              keyboardType: TextInputType.number,
            ),
          ), Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorValor,
              style: const TextStyle(
                fontSize: 24
              ),
              decoration: const InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Valor',
                hintText: '0.00'
              ),
              keyboardType: TextInputType.number,
            ),
          ),

          ElevatedButton(
              onPressed: (){
                debugPrint('clicou no confirmar');
                final int? numeroConta = int.tryParse(_controladorNumeroConta.text);
                final double? valor = double.tryParse(_controladorValor.text);
                if(valor != null && numeroConta != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  debugPrint('$transferenciaCriada');
                }
              },
              child: Text("Confirmar"))
        ],
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Transferencias'),
      ),
      body: Column(
        children: <Widget>[
         ItemTransferencia(Transferencia(100,1000)),
          ItemTransferencia(Transferencia(200,2000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          print('clicou no +');
        },
      ),
    );
  }

}

class ItemTransferencia extends StatelessWidget{

  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(_transferencia.numeroConta.toString()),
        )
    );
  }

}

class Transferencia{

  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}