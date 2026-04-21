import 'package:dio/dio.dart';
import 'package:enr_tickets/core/services/api/api_service.dart';
import 'package:enr_tickets/core/utils/local_storage.dart';
import 'package:enr_tickets/features/create_account/data/repo/signin_repo.dart';
import 'package:enr_tickets/features/create_account/data/repo/signin_repo_implement.dart';
import 'package:enr_tickets/features/create_account/presentation/view/create_account.dart';
import 'package:enr_tickets/features/home/data/repo/station_repo.dart';
import 'package:enr_tickets/features/home/data/repo/station_repo_implement.dart';
import 'package:enr_tickets/features/home/presentation/state_mangement/home_cubit/home_cubit.dart';
import 'package:enr_tickets/features/home/presentation/view/home_view.dart';
import 'package:enr_tickets/features/log_in/data/repo/login_repo.dart';
import 'package:enr_tickets/features/log_in/data/repo/login_repo_implement.dart';
import 'package:enr_tickets/features/settings/presentation/state_mangement/settings_cubit/settings_cubit.dart';
import 'package:enr_tickets/features/seat_selection/presentation/state_mangement/cubit/seat_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn = await LocalStorage.isUserLoggedIn();
  final token = await LocalStorage.getToken();

  final dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.2:5000/api/v1",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final apiService = ApiService(dio);

  try {
    final response = await dio.get("/");
    print("✅ API Connected: ${response.data}");
  } catch (e) {
    print("❌ API Error: $e");
  }

  runApp(
    MyApp(loggedIn: token != null && token.isNotEmpty, apiService: apiService),
  );
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  final ApiService apiService;

  const MyApp({super.key, required this.loggedIn, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SigninRepo>(
          create: (_) => SigninRepoImplement(apiService),
        ),
        RepositoryProvider<LogInRepo>(
          create: (_) => LoginRepoImplement(apiService),
        ),
        RepositoryProvider<StationRepo>(
          create: (_) => StationRepoImplement(apiService),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(create: (_) => SettingsCubit()),
          BlocProvider<SeatSelectionCubit>(create: (_) => SeatSelectionCubit()),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(context.read<StationRepo>()),
          ),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final cubit = context.watch<SettingsCubit>();

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: cubit.locale,
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              themeMode: cubit.themeMode,
              theme: ThemeData(
                brightness: Brightness.light,
                fontFamily: "Quicksand",
                scaffoldBackgroundColor: Colors.white,
                cardColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.black),
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                fontFamily: "Quicksand",
                scaffoldBackgroundColor: Colors.black,
                cardColor: const Color(0xFF1E1E1E),
                iconTheme: const IconThemeData(color: Colors.white),
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.white),
                ),
              ),
              home: loggedIn ? const HomeView() : const CreateAccount(),
            );
          },
        ),
      ),
    );
  }
}
