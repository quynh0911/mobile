import 'package:flutter/material.dart';

class CoinBalance extends StatefulWidget {
  final String icon;
  final String name;
  final BigInt balance;
  final Color color;

  const CoinBalance(
      {Key? key,
      required this.icon,
      required this.name,
      required this.balance,
      required this.color})
      : super(key: key);

  @override
  _CoinBalanceState createState() {
    return _CoinBalanceState();
  }
}

class _CoinBalanceState extends State<CoinBalance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.color,
          border: const Border.fromBorderSide(
              BorderSide(color: Colors.indigoAccent))),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(widget.icon),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.name,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(widget.balance.toString(),
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
