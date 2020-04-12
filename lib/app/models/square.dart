import 'dart:convert';

enum SquareState { inactive, player1Mark, player2Mark }

Square squareFromJson(String str) => Square.fromJson(json.decode(str));

String squareToJson(Square data) => json.encode(data.toJson());

class Square {
  SquareState state;

  Square({
    this.state,
  });

  factory Square.fromJson(Map<String, dynamic> json) => Square(
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
      };
}
