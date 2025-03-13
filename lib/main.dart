import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/networking/api_services.dart';
import 'package:flutter_training_project/networking/base_api_client.dart';
import 'package:flutter_training_project/routing/app_router.dart';
import 'package:flutter_training_project/screens/movies/bloc/fileUploading/file_uploading_cubit.dart';
import 'package:flutter_training_project/screens/movies/bloc/movies/movies_cubit.dart';
import 'package:flutter_training_project/screens/tabbar/bloc/tabbar_cubit.dart';
import 'package:flutter_training_project/services/remotConfig/remote_config_cubit.dart';
import 'package:flutter_training_project/utils/constants/app_config_helper.dart';
import 'package:flutter_training_project/utils/constants/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  await dotenv.load(fileName: ".env");
  // String name = dotenv.env['NAME'] ?? 'Ali';
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfigService();

    final baseApiClient = BaseApiClient(baseUrl: appConfig.baseURL);
    final platziApiClient = BaseApiClient(baseUrl: appConfig.platziBaseURL);

    final apiServices = ApiServices(baseApiClient);
    final platziApiServices = ApiServices(platziApiClient);

    return EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TabbarCubit()),
          BlocProvider(
            create: (_) => RemoteConfigCubit()..fetchRemoteConfigData(),
          ),
          BlocProvider(create: (_) => MoviesCubit(apiServices)..fetchMovies()),
          BlocProvider(create: (_) => FileUploadingCubit(platziApiServices)),
        ],
        child: MyApp(),
      ),
    );
  }
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
