import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_kz/core/singletons/service_locator.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/features/common/bloc/authentication_bloc.dart';
import 'package:test_task_kz/features/login/presentation/blocs/login_bloc.dart';
import 'package:test_task_kz/features/login/presentation/pages/login_screen.dart';
import 'package:test_task_kz/features/navigation/presentation/home.dart';
import 'package:test_task_kz/features/navigation/presentation/navigator.dart';
import 'package:test_task_kz/features/profile/data/repository/profile_repository_impl.dart';
import 'package:test_task_kz/features/profile/domain/usecase/auth_status.dart';
import 'package:test_task_kz/features/profile/domain/usecase/profile_usecase.dart';
import 'package:test_task_kz/features/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigator => _navigatorKey.currentState!;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            statusUseCase: AuthStatusUseCase(
                repository: serviceLocator<ProfileRepositoryImpl>()),
            getUserDataUseCase: ProfileUseCase(
              repository: serviceLocator<ProfileRepositoryImpl>(),
            ),
          ),
        ),
        BlocProvider(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        onGenerateRoute: (settings) => SplashScreen.route(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) =>
            BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.unAuthenticated:
                navigator.pushAndRemoveUntil(
                    fade(const LoginScreen()), (route) => false);
                break;
              case AuthStatus.authenticated:
                navigator.pushAndRemoveUntil(
                    fade(const NavHomeScreen()), (route) => false);
                break;
            }
          },
          child: child,
        ),
      ),
    );
  }
}
