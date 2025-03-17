import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/graphql/graphql_service.dart';
import 'package:flutter_training_project/graphql/product_cubit.dart';
import 'package:flutter_training_project/graphql/queries/collection_query.dart';
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
  fetchCollections();
  runApp(const RootApp());
}

void fetchCollections() async {
  final graphQLService = GraphQLService();
  final response = await graphQLService.performQuery(CollectionsQuery);

  final data = response.data;
  final products = data?['products']?['edges'] ?? [];

  for (var productEdge in products) {
    final product = productEdge['productDetails'];
    print('Product title: ${product['title']}');

    final productCollection = product['relatedCollections']['edges'];

    for (var proCollection in productCollection) {
      final collection = proCollection['collectionInfo'];
      final imageUrl = collection['image']?['url'];
      final altText = collection['image']?['altText'];
      print('Collection Image: $imageUrl');
      print('Alt Text: $altText');
    }
  }
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

    final graphQlService = GraphQLService();

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
          //graphQL cubit
          BlocProvider(
            create:
                (_) =>
                    ProductCollectionCubit(graphQlService)..fetchCollections(),
          ),
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
