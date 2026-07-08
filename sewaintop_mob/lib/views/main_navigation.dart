import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewaintop_mob/blocs/auth/auth_bloc.dart';
import 'package:sewaintop_mob/blocs/auth/auth_state.dart';
import 'package:sewaintop_mob/constants/app_colors.dart';
import 'package:sewaintop_mob/views/home/home_screen.dart';
import 'package:sewaintop_mob/views/booking/my_rentals_screen.dart';
import 'package:sewaintop_mob/views/profile/profile_screen.dart';
import 'package:sewaintop_mob/views/search/search_screen.dart';

// Owner Views
import 'package:sewaintop_mob/views/dashboard/dashboard_view.dart';
import 'package:sewaintop_mob/views/inventory/inventory_view.dart';
import 'package:sewaintop_mob/views/booking_management/booking_request_view.dart';
import 'package:sewaintop_mob/views/calendar/calendar_view.dart';

class MainNavigationScaffold extends StatefulWidget {
  const MainNavigationScaffold({super.key});

  @override
  State<MainNavigationScaffold> createState() => _MainNavigationScaffoldState();
}

class _MainNavigationScaffoldState extends State<MainNavigationScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isOwner = state is Authenticated && state.user.role == 'pemilik';

        final List<Widget> screens = isOwner
            ? [
                const DashboardView(),
                const InventoryView(),
                const BookingRequestView(),
                const CalendarView(),
                const ProfileScreen(),
              ]
            : [
                const HomeScreen(),
                const SearchScreen(),
                const MyRentalsScreen(),
                const ProfileScreen(),
              ];

        // Safely bound the index if the screen configuration changes
        final index = _currentIndex < screens.length ? _currentIndex : 0;

        final List<BottomNavigationBarItem> navItems = isOwner
            ? const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  activeIcon: Icon(Icons.inventory_2),
                  label: 'Inventaris',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  activeIcon: Icon(Icons.assignment),
                  label: 'Permintaan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  activeIcon: Icon(Icons.calendar_month),
                  label: 'Kalender',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ]
            : const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: 'Cari',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  activeIcon: Icon(Icons.assignment),
                  label: 'Sewa Saya',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ];

        return Scaffold(
          body: IndexedStack(
            index: index,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textMuted,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
            ),
            items: navItems,
          ),
        );
      },
    );
  }
}
