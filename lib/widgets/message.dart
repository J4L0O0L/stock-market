import 'package:flutter/material.dart';
import 'package:stock_market_chart/widgets/empty_screen.dart';

class MessageScreen extends StatelessWidget {
  final String message;
  final Widget action;

  const MessageScreen({
    Key? key,
    required this.message,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
        child: Column(
          children: <Widget>[
            EmptyScreen(message: message),
          ],
        ));
  }
}
