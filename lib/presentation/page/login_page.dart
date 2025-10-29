import 'package:animate_do/animate_do.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_motionly/widget/button/animated_state_button.dart';
import 'package:go_router/go_router.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as thm;

import '../state/login/login_bloc.dart';
import '../widget/email_field.dart';
import '../widget/password_field.dart';
import 'login_section/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Duration _delay = Consts.durations.base.xs;
  late final AnimatedStateButtonController _loginButtonController;
  bool _hasShownRedirectMessage = false;

  @override
  void initState() {
    super.initState();
    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    _loginButtonController = AnimatedStateButtonController(
      states: {
        'success': ButtonState.success(color: theme.success),
        'loading': ButtonState.loading(color: theme.primary, fg: theme.bgDark),
        'error': ButtonState.error(color: theme.danger),
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkRedirect();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    return Scaffold(
      backgroundColor: theme.bgDark,
      body: BlocConsumer<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.isChecking != current.isChecking,
        listenWhen: (previous, current) {
          bool isDifferentError = current.hasError && current.errorMessage != null && current.errorMessage != previous.errorMessage;
          return isDifferentError;
        },
        listener: (context, state) {
          _loginButtonController.changeState('error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _getErrorMessage(state.errorMessage, context),
                style: TextStyle(
                  color: theme.bgDark,
                  fontWeight: FontWeight.w600,
                  fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.body),
                ),
              ),
              backgroundColor: theme.primary,
              duration: Consts.durations.base.giant,
            ),
          );
          _loginButtonController.changeState('init');
          context.read<LoginBloc>().add(LoginClearError());
        },
        builder: (context, state) {
          final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
          return SafeArea(
            child: SingleChildScrollView(
              padding: Consts.spacing.padding.huge,
              child: Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeader(),
                    FadeInUp(
                      duration: Consts.durations.base.md,
                      child: EmailField(
                        controller: _emailController,
                        enabled: !state.isChecking,
                      ),
                    ),
                    Consts.spacing.gap.lgx,
                    FadeInUp(
                      duration: Consts.durations.base.md,
                      delay: _delay,
                      child: PasswordField(
                        controller: _passwordController,
                        enabled: !state.isChecking,
                      ),
                    ),
                    Consts.spacing.gap.huge,
                    FadeInUp(
                      duration: Consts.durations.base.md,
                      delay: _delay * 1.3,
                      child: Center(
                        child: AnimatedStateButton(
                          controller: _loginButtonController,
                          initColor: theme.primary,
                          padding: Consts.spacing.padding.none,
                          borderRadius: Consts.radius.base.huge,
                          compactSize: Consts.sizes.base.mega,
                          height: Consts.sizes.base.mega,
                          onPressed: () async => _login(context),
                          initChild: Text(
                            context.l10n.signIn,
                            style: TextStyle(
                              fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.bodySmall),
                              fontWeight: FontWeight.w600,
                              color: theme.bgDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Consts.spacing.gap.huge,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _checkRedirect() {
    final uri = GoRouterState.of(context).uri;
    final isRedirect = uri.queryParameters['redirect'] == 'true';

    if (!isRedirect || _hasShownRedirectMessage) return;

    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    _hasShownRedirectMessage = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.loginRequired,
          style: TextStyle(
            color: theme.bgDark,
            fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.body),
          ),
        ),
        backgroundColor: theme.warning,
        duration: Consts.durations.base.giant,
      ),
    );
  }

  void _login(BuildContext context) {
    var isValidForLogin = _loginFormKey.currentState?.validate() ?? false;
    if (!isValidForLogin) return;
    _loginButtonController.changeState('loading');
    context.read<LoginBloc>().add(
      LoginSubmit(_emailController.text.trim(), _passwordController.text),
    );
  }

  String _getErrorMessage(String? errorMessage, BuildContext context) {
    if (errorMessage == null) return context.l10n.authenticationFailed;

    switch (errorMessage) {
      case 'INVALID_CREDENTIALS':
        return context.l10n.invalidCredentials;
      case 'SERVER_ERROR':
        return context.l10n.serverError;
      case 'NETWORK_ERROR':
        return context.l10n.networkError;
      case 'UNEXPECTED_ERROR':
        return context.l10n.unexpectedError;
      default:
        return context.l10n.authenticationFailed;
    }
  }
}
