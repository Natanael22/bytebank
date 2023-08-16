import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),

      home: ListaTransferencias(),
      );
  }
}

class FormularioTransferencia extends StatefulWidget {

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia>{

    final TextEditingController _controladorNumeroConta = TextEditingController();
    final TextEditingController _controladorValor = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Criando Transferencia"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                  controlador: _controladorNumeroConta,
                  rotulo: "Numero da conta",
                  dica: '0000',
                  icone: null),
              Editor(
                  controlador: _controladorValor,
                  rotulo: 'Valor',
                  dica: '0.00',
                  icone: Icons.monetization_on),
              ElevatedButton(
                child: Text("Confirmar"),
                onPressed: () => _criaTransferencia(context),

              )
            ],
          ),
        ),
      );
    }

    void _criaTransferencia(BuildContext context) {
      final int? numeroConta = int.tryParse(_controladorNumeroConta.text);
      final double? valor = double.tryParse(_controladorValor.text);
      if (valor != null && numeroConta != null) {
        final transferenciaCriada = Transferencia(valor, numeroConta);
        //debugPrint('criando a transferencia');
        debugPrint('cria: $context $transferenciaCriada');
        debugPrint('context form: $context');
        Navigator.pop(context, transferenciaCriada);
      }
    }
}

class ListaTransferencias extends StatefulWidget {

  final List<Transferencia> _transferencias = <Transferencia>[];

  @override
  State<StatefulWidget> createState() {
    debugPrint('lista trans: $_transferencias');
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //widget._transferencias.add(Transferencia(100, 100));
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencias'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index) {
          debugPrint('context list: $context');
          final transf = widget._transferencias[index];
          debugPrint('item: $transf');
          return ItemTransferencia(transf);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
               // debugPrint('context onpress: $context');
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            //debugPrint('chegou no then do future');
            //
            if (transferenciaRecebida != null) {
              //debugPrint('transf rec: $transferenciaRecebida');
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });

            }
            print(widget._transferencias.length);
          });
        },
      ),
    );
  }


}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {super.key});

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

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {

    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
