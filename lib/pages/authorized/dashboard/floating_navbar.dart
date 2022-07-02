import 'package:flutter/material.dart';

class FloatingNavbar extends StatefulWidget {
  const FloatingNavbar({Key? key, required this.updateCurrentPage}) : super(key: key);

  final void Function(int) updateCurrentPage;

  @override
  State<FloatingNavbar> createState() => _FloatingNavbarState();
}

class _FloatingNavbarState extends State<FloatingNavbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 64,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff02c3d6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: ()=>widget.updateCurrentPage(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // SvgPicture.asset('assets/imgs/dashboard.svg'),
                    Icon(Icons.dashboard_rounded, color: Colors.white,),
                     Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Signika",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: ()=>widget.updateCurrentPage(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    // SvgPicture.asset('assets/imgs/duitnow.svg'),
                    Icon(Icons.qr_code_scanner_rounded, color: Colors.white,),
                    Text(
                      "DuitNow",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Signika",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: ()=>widget.updateCurrentPage(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // SvgPicture.asset('assets/imgs/stats.svg'),
                    Icon(Icons.bar_chart_rounded, color: Colors.white,),
                    Text(
                      "Stats",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Signika",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
