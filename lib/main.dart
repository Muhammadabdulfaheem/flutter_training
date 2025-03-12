import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/networking/api_services.dart';
import 'package:flutter_training_project/networking/base_api_client.dart';
import 'package:flutter_training_project/providers.dart/home_api_provider.dart';
import 'package:flutter_training_project/providers.dart/bottom_nav_provider.dart';
import 'package:flutter_training_project/providers.dart/remot_config_provider.dart';
import 'package:flutter_training_project/providers.dart/search_tab_api_provider.dart';
import 'package:flutter_training_project/routing/app_router.dart';
import 'package:flutter_training_project/screens/movies/bloc/movies_cubit.dart';
import 'package:flutter_training_project/utils/constants/app_config_helper.dart';
import 'package:flutter_training_project/utils/constants/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  await dotenv.load(fileName: ".env");
  String name = dotenv.env['NAME'] ?? 'Ali';

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final appConfig = AppConfigService();
  final baseApiClient = BaseApiClient(baseUrl: appConfig.baseURL);
  final apiServices = ApiServices(baseApiClient);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => RemotConfigProvider()),
          ChangeNotifierProvider(create: (context) => BottomNavProvider()),
          // ChangeNotifierProvider(create: (context) => HomeApiProvider()),
          // ChangeNotifierProvider(create: (context) => SearchTabApiProvider()),
        ],

        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create:
                  (context) => MoviesCubit(
                    ApiServices(BaseApiClient(baseUrl: appConfig.baseURL)),
                  ),
            ),
          ],
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.createRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}
