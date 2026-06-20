import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

// Auth
import 'features/authentication/data/datasources/auth_local_datasource.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';
import 'features/authentication/domain/usecases/register_usecase.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';

// Home
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/presentation/providers/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // System UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF0B0E11),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize services
  final prefs = await SharedPreferences.getInstance();

  // ──────────────────────────────────────
  // Dependency Injection
  // ──────────────────────────────────────

  // Auth
  final authLocalDatasource = AuthLocalDatasource(prefs);
  final AuthRepository authRepository = AuthRepositoryImpl(authLocalDatasource);
  final loginUseCase = LoginUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);

  // Home
  final HomeRepository homeRepository = HomeRepositoryImpl();

  runApp(
    MultiProvider(
      providers: [
        // Auth
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginUseCase: loginUseCase,
            registerUseCase: registerUseCase,
            authRepository: authRepository,
          ),
        ),

        // Home
        ChangeNotifierProvider(
          create: (_) => HomeProvider(repository: homeRepository),
        ),
      ],
      child: const BinanceApp(),
    ),
  );
}
