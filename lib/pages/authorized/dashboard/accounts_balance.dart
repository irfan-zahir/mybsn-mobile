import 'package:flutter/material.dart';

class AccountsBalance extends StatefulWidget {
  const AccountsBalance(
      {Key? key, required this.selectedBalance, required this.totalBalance})
      : super(key: key);
  final String totalBalance;
  final String selectedBalance;

  @override
  State<AccountsBalance> createState() => _AccountsBalanceState();
}

class _AccountsBalanceState extends State<AccountsBalance> {
  @override
  Widget build(BuildContext context) {
    var selectedBalance = widget.selectedBalance;
    return Container(
        height: 175,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Stack(
          children: [
            Positioned.fill(
              top: 0,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 24,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: const Color(0xff029aa8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Savings account',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Signika',
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      selectedBalance,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: "Signika",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned.fill(
              bottom: 0,
              top: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Total balance",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Signika",
                          // fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        widget.totalBalance,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "Signika",
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
