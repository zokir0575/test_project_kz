import 'package:flutter/material.dart';
import 'package:test_task_kz/assets/constants/app_icons.dart';
import 'package:test_task_kz/features/navigation/domain/entities/navbar.dart';
import 'package:test_task_kz/features/navigation/presentation/navigator.dart';
import 'package:test_task_kz/features/navigation/presentation/widgets/nav_bar_item.dart';

enum NavItemEnum { head, newPost, categories, profile }

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (_) => const NavHomeScreen(),
      );

//kordizmi
  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.head: GlobalKey<NavigatorState>(),
    NavItemEnum.newPost: GlobalKey<NavigatorState>(),
    NavItemEnum.categories: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  final List<NavBar> lables = [
    const NavBar(
      title: 'Лента',
      id: 0,
      icon: AppIcons.lenta,
    ),
    const NavBar(
      title: 'Карта',
      id: 1,
      icon: AppIcons.map,
    ),
    const NavBar(
      title: 'Избранные',
      id: 2,
      icon: AppIcons.heart,
    ),
    const NavBar(
      title: 'Профиль',
      id: 3,
      icon: AppIcons.profile,
    ),
  ];

  int _currentIndex = 3;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    _controller.index = _currentIndex;
    _controller.addListener(onTabChange);

    super.initState();
  }


  void onTabChange() => setState(() => _currentIndex = _controller.index);

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      );

  void changePage(int index) {
    setState(() => _currentIndex = index);
    _controller.animateTo(index);
  }

  @override
  Widget build(BuildContext context) => HomeTabControllerProvider(
        controller: _controller,
        child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await _navigatorKeys[NavItemEnum.values[_currentIndex]]!
                    .currentState!
                    .maybePop();
            if (isFirstRouteInCurrentTab) {
              if (NavItemEnum.values[_currentIndex] != NavItemEnum.head) {
                changePage(0);
                return false;
              }
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: ClipRect(
              child: Container(
                height: 68 + MediaQuery.of(context).padding.bottom,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF171725).withOpacity(0.64),
                      blurRadius: 24,
                      offset: const Offset(0, -8),
                    )
                  ],
                ),
                child: TabBar(
                  enableFeedback: true,
                  onTap: (index) {},
                  indicator: const BoxDecoration(),
                  controller: _controller,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    NavItemWidget(
                      navBar: lables[0],
                      currentIndex: _currentIndex,
                    ),
                    NavItemWidget(
                      navBar: lables[1],
                      currentIndex: _currentIndex,
                    ),
                    NavItemWidget(
                      navBar: lables[2],
                      currentIndex: _currentIndex,
                    ),
                    NavItemWidget(
                      navBar: lables[3],
                      currentIndex: _currentIndex,
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPageNavigator(NavItemEnum.head),
                _buildPageNavigator(NavItemEnum.newPost),
                _buildPageNavigator(NavItemEnum.categories),
                _buildPageNavigator(NavItemEnum.profile),
              ],
            ),
          ),
        ),
      );
}

class HomeTabControllerProvider extends InheritedWidget {
  final TabController controller;

  const HomeTabControllerProvider({
    required Widget child,
    required this.controller,
    Key? key,
  }) : super(key: key, child: child);

  static HomeTabControllerProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>();
    assert(result != null, 'No HomeTabControllerProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;
}
