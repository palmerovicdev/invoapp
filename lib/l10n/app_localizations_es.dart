// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get about => 'Acerca De';

  @override
  String get close => 'Cerrar';

  @override
  String get retry => 'Reintentar';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get doYouWantToLogout => '¿Quieres cerrar sesión?';

  @override
  String get requestFailed => 'La solicitud falló.';

  @override
  String get pleaseCheckYourConnection =>
      'Por favor, verifica tu conexión a internet.';

  @override
  String get transactions => 'Transacciones';

  @override
  String get youHaveNoInvoices => 'No tienes facturas.';

  @override
  String get aboutApp => 'Información';

  @override
  String get themeColor => 'Color del tema';

  @override
  String get welcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get invoApp => 'InvoApp';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get incorrectEmailOrPassword =>
      'Correo electrónico o contraseña incorrectos';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get dontHaveAnAccount => '¿No tienes una cuenta?';

  @override
  String get signUp => 'Regístrate';

  @override
  String get emailInvalid => 'El correo electrónico no es válido';

  @override
  String get emailRequired => 'El correo electrónico es obligatorio';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get passwordTooShort => 'La contraseña es demasiado corta';

  @override
  String get loginRequired => 'El inicio de sesión es obligatorio';

  @override
  String get authenticationFailed => 'Autenticación fallida';

  @override
  String get invalidCredentials => 'Credenciales inválidas';

  @override
  String get serverError => 'Error del servidor';

  @override
  String get networkError => 'Error de red';

  @override
  String get unexpectedError => 'Error inesperado';

  @override
  String get authenticationError => 'Error de autenticación';

  @override
  String get checkingAuth => 'Verificando autenticación...';

  @override
  String get loading => 'Cargando...';

  @override
  String get lastUpdated => 'Última actualización';

  @override
  String get justNow => 'Ahora mismo';

  @override
  String lastDays(int days) {
    return 'Últimos $days días';
  }

  @override
  String get invoices => 'Facturas';

  @override
  String get send => 'Enviar';

  @override
  String get received => 'Recibido';

  @override
  String get cancel => 'Cancelar';

  @override
  String get search => 'Buscar';

  @override
  String get noResults => 'No se encontraron resultados';

  @override
  String get paid => 'Pagado';

  @override
  String get awaitingPayment => 'En espera de pago';

  @override
  String get overdue => 'Vencido';

  @override
  String get draft => 'Borrador';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get issued => 'Emitida';

  @override
  String get due => 'Vencimiento';

  @override
  String get reference => 'Referencia';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get tax => 'Impuesto';

  @override
  String get total => 'Total';
}
