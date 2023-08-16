import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

const _tituloAppBar = 'Transferencias';

class ListaTransferencias extends StatefulWidget {

  final List<Transferencia> _transferencias = <Transferencia>[];

  @override
  State<StatefulWidget> createState() {
    //debugPrint('lista trans: $_transferencias');
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
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index) {
          //debugPrint('context list: $context');
          final transf = widget._transferencias[index];
          //debugPrint('item: $transf');
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
            //print(widget._transferencias.length);
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