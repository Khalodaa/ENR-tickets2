import 'package:enr_tickets/core/utils/app_strings.dart';
import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/features/home/data/repo/station_repo.dart';
import 'package:enr_tickets/features/home/presentation/state_mangement/home_cubit/home_cubit.dart';
import 'package:enr_tickets/features/home/presentation/view/pages/home_page.dart';
import 'package:enr_tickets/features/my_tickets/presentation/view/my_tickets_page.dart';
import 'package:enr_tickets/features/settings/presentation/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 2;

  final List<Widget> _pages = const [
    SettingsPage(),
    MyTicketsPage(),
    HomePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit( context.read<StationRepo>())..getStations(),
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconSize: 30,
          elevation: 20,
          selectedFontSize: 17,
          showSelectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          currentIndex: _currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: iconColor,
          unselectedItemColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.grey[600],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppStrings.of(context, "settingsPage"),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: AppStrings.of(context, "myTickets"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppStrings.of(context, "homePage"),
            ),
          ],
        ),
      ),
    );
  }
}
