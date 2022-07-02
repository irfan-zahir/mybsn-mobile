import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {Key? key,
      required this.description,
      required this.amount,
      required this.type,
      required this.date})
      : super(key: key);

  final String description;
  final String amount;
  final String date;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: const Color(0xffd9d9d9)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              this.description,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Signika',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            this.amount,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Signika',
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.date,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Signika',
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
          Text(
            this.type,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Signika',
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
