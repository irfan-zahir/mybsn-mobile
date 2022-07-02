import 'package:flutter/material.dart';
import 'package:mobile/api/dashboard_api.dart';
import 'package:mobile/classes/login_state.dart';
import 'package:mobile/pages/authorized/dashboard/accounts_balance.dart';
import 'package:mobile/pages/authorized/dashboard/header.dart';
import 'package:mobile/pages/authorized/dashboard/recent_transactions/recent_transactions.dart';
import 'package:mobile/pages/authorized/dashboard/send_money/send_money.dart';
import 'package:mobile/widgets/loading_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
      {Key? key,
      required this.hideBottomNavbar,
      this.hideNavbar = false,
      required this.loginState})
      : super(key: key);
  final void Function(bool) hideBottomNavbar;
  final bool hideNavbar;
  final LoginState loginState;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final Future<Map<String, dynamic>> dashboard_data =
      getDashboardInfo(widget.loginState);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: dashboard_data,
        builder: (context, snap) {
          if (snap.hasData) {
            var data = snap.data!;
            return StatefulBuilder(builder: (context, setState) {
              var currentAcc = Map.from(data['saving_accs'][0]);
              // late final Future<Map<String, dynamic>> recent_transactions =
              //     getRecentTransactions(
              //         widget.loginState, currentAcc['listNumber']);

              // updateSelectedAcc(selectedAcc) {
              //   setState(
              //     () {
              //       currentAcc = selectedAcc;
              //     },
              //   );
              // }

              return Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DashboardHeader(
                        profile_image: data['profile_image'],
                        preferedName: data['display_name'],
                      ),
                      AccountsBalance(
                        selectedBalance: 'RM ${currentAcc["balance"]}',
                        totalBalance: data['saving_balance'],
                      ),
                      const SendMoney(),
                    ],
                  ),
                  RecentTransactions(
                    hideBottomNavbar: widget.hideBottomNavbar,
                    loginState: widget.loginState,
                    selectedAcc: currentAcc,
                  ),
                ],
              );
            });
          }
          return const Center(
              child: DottedCircularProgressIndicatorFb(numDots: 10));
        });
  }
}
