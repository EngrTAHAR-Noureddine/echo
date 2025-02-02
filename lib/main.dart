import 'package:echo/bloc/cubit/app_language_cubit.dart';
import 'package:echo/constant/constant.dart';
import 'package:echo/constant/enums.dart';
import 'package:echo/data/hivebase.dart';
import 'package:echo/router.dart';
import 'package:echo/screen/home_screen.dart';
import 'package:echo/screen/login_screen.dart';
import 'package:echo/service/fire_message_service.dart';
import 'package:echo/style/theme.dart';
import 'package:echo/translation/main.dart';
import 'package:echo/utils/app_singleton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBase.init();
  AppSingleton.instance.setUser = HiveBase.hiveBase.getUser();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FireMessageService.instance.init();
  await FireMessageService.instance.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppLanguageCubit>(
            create: (context) =>
                AppLanguageCubit(HiveBase.hiveBase.getLanguage()),
          ),
        ],
        child: BlocBuilder<AppLanguageCubit, LanguageCode>(
          builder: (context, language) {
            AppLanguage.setStrings(language);
            return MaterialApp(
              title: 'Echo',
              debugShowCheckedModeBanner: false,
              theme: CustomTheme.of.lightMode,
              home: (HiveBase.hiveBase.getToken() != null)
                  ? HomeScreen()
                  : LoginScreen(),
              navigatorKey: navigatorKey,
              onGenerateRoute: RouterGenerator.getRouter,
            );
          },
        ));
  }
}
