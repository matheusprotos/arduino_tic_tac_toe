import 'package:arduino_tic_tac_toe/app/models/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    controller.loadSquares();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arduino TicTacToe"),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() => Column(
        children: <Widget>[_message(), _gridView()],
      );

  Widget _message() => Padding(
        padding: EdgeInsets.only(top: 50, bottom: 50),
        child: Observer(
          builder: (BuildContext context) => Text(
            controller.message.value,
            style: TextStyle(fontSize: 30, color: controller.getMessageColor()),
          ),
        ),
      );

  Widget _gridView() => Expanded(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: controller.squares.length,
          itemBuilder: (BuildContext context, int index) => _squareItem(index),
        ),
      );

  Widget _squareItem(int index) => Observer(
        builder: (BuildContext context) => GestureDetector(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: const Color(0xFF000000)),
              color: controller.getSquareColor(controller.squares[index]),
            ),
          ),
          onTap: () => controller.makePlay(index),
        ),
      );
}
