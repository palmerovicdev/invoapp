import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:invoapp/core/locator.dart';
import 'package:invoapp/presentation/state/home/home_bloc.dart';
import 'package:invoapp/presentation/state/login/login_bloc.dart';

import 'core/route/router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      basePath: 'assets/i18n',
      fallbackFile: 'en',
      useCountryCode: false,
    ),
  );

  await flutterI18nDelegate.load(Locale('en'));
  runApp(MyApp(delegate: flutterI18nDelegate));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate delegate;

  const MyApp({
    super.key,
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return _BlocWrapper(
      delegate: delegate,
      child: SizedBox.shrink(),
    );
  }
}

class _BlocWrapper extends StatelessWidget {
  final Widget child;
  final FlutterI18nDelegate delegate;

  const _BlocWrapper({
    required this.child,
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(loginService)..add(LoginCheckSession()),
      child: Builder(
        builder: (context) {
          final loginBloc = context.read<LoginBloc>();
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeBloc(invoiceService, loginBloc),
              ),
            ],
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                router.authStateNotifier.value = state.status;
              },
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) => previous.theme != current.theme || previous.locale != current.locale,
                builder: (context, homeState) => MaterialApp.router(
                  title: 'InvoApp',
                  debugShowCheckedModeBanner: false,
                  routerConfig: router.router,
                  locale: homeState.locale,
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
                  localizationsDelegates: [
                    delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
