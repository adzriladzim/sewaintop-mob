import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewaintop_mob/blocs/auth/auth_bloc.dart';
import 'package:sewaintop_mob/blocs/auth/auth_event.dart';
import 'package:sewaintop_mob/blocs/laptop/laptop_bloc.dart';
import 'package:sewaintop_mob/blocs/booking/booking_bloc.dart';
import 'package:sewaintop_mob/repositories/auth_repository.dart';
import 'package:sewaintop_mob/repositories/laptop_repository.dart';
import 'package:sewaintop_mob/repositories/booking_repository.dart';
import 'package:sewaintop_mob/data/local_database.dart';
import 'package:sewaintop_mob/views/auth/splash_screen.dart';
import 'package:sewaintop_mob/views/dashboard/dashboard_view.dart';
import 'package:sewaintop_mob/views/inventory/inventory_view.dart';
import 'package:sewaintop_mob/views/inventory/add_laptop_view.dart';
import 'package:sewaintop_mob/views/booking_management/booking_request_view.dart';
import 'package:sewaintop_mob/views/calendar/calendar_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Local SQLite Database
  // final localDb = LocalDatabase();
  // await localDb.database;

  // Initialize Repositories
  final authRepository = AuthRepository();
  final laptopRepository = LaptopRepository();
  final bookingRepository = BookingRepository();

  runApp(MyApp(
    authRepository: authRepository,
    laptopRepository: laptopRepository,
    bookingRepository: bookingRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final LaptopRepository laptopRepository;
  final BookingRepository bookingRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.laptopRepository,
    required this.bookingRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<LaptopRepository>.value(value: laptopRepository),
        RepositoryProvider<BookingRepository>.value(value: bookingRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: authRepository)..add(CheckAuthStatus()),
          ),
          BlocProvider<LaptopBloc>(
            create: (context) => LaptopBloc(laptopRepository: laptopRepository),
          ),
          BlocProvider<BookingBloc>(
            create: (context) => BookingBloc(bookingRepository: bookingRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Sewaintop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2563EB),
              primary: const Color(0xFF2563EB),
            ),
            useMaterial3: true,
            fontFamily: 'Inter',
          ),
          home: const DashboardView(),
        ),
      ),
    );
  }
}
