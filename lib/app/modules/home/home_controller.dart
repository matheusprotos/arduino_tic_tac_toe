import 'package:arduino_tic_tac_toe/app/models/square.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  List<dynamic> squaresJson = [
    {"state": SquareState.inactive},
    {"state": SquareState.inactive},
    {"state": SquareState.inactive},
    {"state": SquareState.inactive},
    {"state": SquareState.inactive},
    {"state": SquareState.inactive},
    {"state": SquareState.inactive},
    {"state": SquareState.inactive},
    {"state": SquareState.inactive}
  ];
  ObservableList<Square> squares;

  Observable<bool> isPlayer1Turn = Observable(true);

  Observable<String> message = Observable("Turno de Player 1");

  bool checkDraw() =>
      squares
          .where((Square square) => square.state == SquareState.inactive)
          .length ==
      0;

  bool checkWin() =>
      ((squares[0].state != SquareState.inactive) &&
          (squares[0].state == squares[1].state) &&
          (squares[1].state == squares[2].state)) ||
      ((squares[3].state != SquareState.inactive) &&
          (squares[3].state == squares[4].state) &&
          (squares[4].state == squares[5].state)) ||
      ((squares[6].state != SquareState.inactive) &&
          (squares[6].state == squares[7].state) &&
          (squares[7].state == squares[8].state)) ||
      ((squares[0].state != SquareState.inactive) &&
          (squares[0].state == squares[3].state) &&
          (squares[3].state == squares[6].state)) ||
      ((squares[1].state != SquareState.inactive) &&
          (squares[1].state == squares[4].state) &&
          (squares[4].state == squares[7].state)) ||
      ((squares[2].state != SquareState.inactive) &&
          (squares[2].state == squares[5].state) &&
          (squares[5].state == squares[8].state)) ||
      ((squares[0].state != SquareState.inactive) &&
          (squares[0].state == squares[4].state) &&
          (squares[4].state == squares[8].state)) ||
      ((squares[2].state != SquareState.inactive) &&
          (squares[2].state == squares[4].state) &&
          (squares[4].state == squares[6].state));

  Color getMessageColor() {
    Color messageColor;

    if (checkDraw())
      messageColor = Colors.red;
    else
      messageColor = isPlayer1Turn.value ? Colors.green : Colors.blue;

    return messageColor;
  }

  Color getSquareColor(Square square) {
    Color squareColor;

    switch (square.state) {
      case SquareState.inactive:
        squareColor = Colors.red;
        break;
      case SquareState.player1Mark:
        squareColor = Colors.green;
        break;
      case SquareState.player2Mark:
        squareColor = Colors.blue;
        break;
    }

    return squareColor;
  }

  void loadSquares() {
    squares = ObservableList<Square>.of(
        squaresJson.map((dynamic square) => Square.fromJson(square)).toList());
  }

  @action
  void makePlay(int index) {
    Square newSquare = squares[index];

    newSquare.state =
        isPlayer1Turn.value ? SquareState.player1Mark : SquareState.player2Mark;

    squares.replaceRange(index, index + 1, [newSquare]);

    if (checkDraw())
      message.value = "Empate!";
    else if (checkWin())
      message.value = "Player ${isPlayer1Turn.value ? "1" : "2"} venceu!";
    else {
      isPlayer1Turn = Observable(!isPlayer1Turn.value);
      message.value = "Turno de Player ${isPlayer1Turn.value ? "1" : "2"}";
    }
  }
}
