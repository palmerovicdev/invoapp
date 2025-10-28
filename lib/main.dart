import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:invoapp/core/locator.dart';
import 'package:invoapp/presentation/state/home/home_bloc.dart';
import 'package:invoapp/presentation/state/login/login_bloc.dart';

import 'core/route/router.dart' as router;
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _BlocWrapper(
      child: MaterialApp.router(
        title: 'InvoApp',
        debugShowCheckedModeBanner: false,
        routerConfig: router.router,
        locale: Locale('en'),
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}

class _BlocWrapper extends StatelessWidget {
  final Widget child;

  const _BlocWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(loginService)..add(LoginCheckSession()),
        ),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          router.authStateNotifier.value = state.status;
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => previous.theme != current.theme,
          builder: (_, _) => child,
        ),
      ),
    );
  }
}
