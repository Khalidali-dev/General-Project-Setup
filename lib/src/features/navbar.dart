import 'package:iserve/src/src.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> screens = [];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          labelPadding: EdgeInsets.zero,
          selectedIndex: currentIndex,
          onDestinationSelected: (value) =>
              setState(() => currentIndex = value),
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/images/home-2.svg',
                color: currentIndex == 0
                    ? const Color(0xFF9470B7)
                    : Colors.black.withValues(alpha: 0.7),
              ),
              label: "",
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/images/global-search.svg',
                color: currentIndex == 1
                    ? const Color(0xFF9470B7)
                    : Colors.black.withValues(alpha: 0.7),
              ),
              label: "",
            ),
            NavigationDestination(
              icon: Container(
                height: 44,
                width: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFECECEC).withValues(alpha: 0.53),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Icon(Icons.add, color: Colors.black)),
              ),
              label: "",
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/images/sms-notification.svg',
                color: currentIndex == 3
                    ? const Color(0xFF9470B7)
                    : Colors.black.withValues(alpha: 0.7),
              ),
              label: "",
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/images/user.svg',
                color: currentIndex == 4
                    ? const Color(0xFF9470B7)
                    : Colors.black.withValues(alpha: 0.7),
              ),
              label: "",
            ),
          ],
        ),
      ),
      body: IndexedStack(index: currentIndex, children: screens),
    );
  }
}
