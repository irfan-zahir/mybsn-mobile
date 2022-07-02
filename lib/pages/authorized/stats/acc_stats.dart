import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountStatistics extends StatefulWidget {
  const AccountStatistics({Key? key}) : super(key: key);

  @override
  State<AccountStatistics> createState() => _AccountStatisticsState();
}

class _AccountStatisticsState extends State<AccountStatistics> {
  @override
  Widget build(BuildContext context) {
    return const Text('Account statistic page');
  }
}