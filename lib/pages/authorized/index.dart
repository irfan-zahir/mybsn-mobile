import 'package:flutter/material.dart';
import 'package:mobile/classes/login_state.dart';
import 'package:mobile/pages/authorized/dashboard/dashboard.dart';
import 'package:mobile/pages/authorized/dashboard/floating_navbar.dart';
import 'package:mobile/pages/authorized/duitnowqr/duitnow_qr.dart';
import 'package:mobile/pages/authorized/stats/acc_stats.dart';
import 'package:mobile/widgets/Background.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _hideNavbar = false;

  void handleHideNavbar(bool hide) {
    setState(() {
      _hideNavbar = hide;
    });
  }

  int currentPage = 0;

  void updateCurrentPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  renderLandingPage(int currentPage, LoginState loginState) {
    final landingPages = [
      Dashboard(
        hideBottomNavbar: handleHideNavbar,
        hideNavbar: _hideNavbar,
        loginState: loginState,
      ),
      DuitNowQR(),
      AccountStatistics()
    ];

    return landingPages[currentPage];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (context, loginState, _) {
        return BodyContainer(
            child: Stack(
          children: [
            renderLandingPage(currentPage, loginState),
            Positioned(
              bottom: 20,
              child: AnimatedOpacity(
                  opacity: _hideNavbar ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: FloatingNavbar(updateCurrentPage: updateCurrentPage)),
            )
          ],
        ));
      }
    );
  }
}
