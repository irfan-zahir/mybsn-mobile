import 'package:flutter/material.dart';
import 'package:mobile/pages/authorized/dashboard/send_money/contact_card.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Send money",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: "Signika",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: "Signika",
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                ContactCard(),
                const SizedBox(width: 8),
                ContactCard(
                  contact_image: '',
                  contact_name: 'Irfan',
                ),
              ],
            )
          ],
        ));
  }
}
