# 🧾 InvoApp

> Aplicación móvil moderna para listado y gestión de facturas, construida con Flutter y arquitectura limpia

<div align="center">

![Flutter Version](https://img.shields.io/badge/Flutter-3.9.2-blue)
![Dart Version](https://img.shields.io/badge/Dart-3.9.2-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Platforms](https://img.shields.io/badge/platform-iOS%20%7C%20Android-lightgrey)

[Descripción](#-descripción) • [Características](#-características) • [Capturas](#-capturas-de-pantalla) • [Tecnologías](#-tecnologías) • [Instalación](#-instalación)

</div>

<p align="center">
  <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2020.08.58.png" width="50%" alt="Pantalla principal - InvoApp">
</p>

---

## 📖 Descripción

**InvoApp** es una aplicación móvil desarrollada con Flutter que permite gestionar y visualizar facturas de manera intuitiva. La aplicación cuenta con una interfaz moderna que incluye navegación fluida, búsqueda en tiempo real, filtros avanzados por fecha, paginación inteligente y retroalimentación háptica.

### 🎯 Objetivos principales

- Mostrar listado completo de facturas con paginación
- Permitir búsqueda y filtrado avanzado
- Proporcionar una experiencia de usuario fluida con animaciones
- Implementar manejo robusto de errores y estados vacíos
- Seguir una arquitectura limpia y escalable

---

## ✨ Características

### 🎨 Interfaz y UX
- **🔄 PageView sincronizado** con lista inferior para navegación intuitiva
- **🔍 Búsqueda en tiempo real** con debounce para optimización
- **📅 Filtros por fecha** con acciones rápidas (últimos 7/30 días, mes actual)
- **🎧 Retroalimentación háptica** en todas las interacciones clave
- **🚨 Feedback visual** para estados de error (pérdida de conexión, etc.)
- **🪄 Pantallas de Empty State** con botones de reintento
- **💫 Splash screen animada** con transición suave
- **🧿 Icono minimalista** coherente con la identidad visual

### 🏗️ Arquitectura
- **🧱 Arquitectura limpia** (Clean Architecture)
- **🎯 Manejo de estado con BLoC** pattern
- **🔒 Inyección de dependencias** con GetIt
- **🌐 Localización** multiidioma (Español/Inglés)
- **🎨 Tema personalizado** coherente

### 🚀 Rendimiento
- **⚡ Carga optimizada** con paginación
- **🖼️ Cache de imágenes** con `cached_network_image`
- **🎭 Animaciones fluidas** con `flutter_motionly` y `animate_do`
- **📦 Build eficiente** con generación de código

---

## 📱 Capturas de pantalla

<div align="center">

### Pantalla principal y navegación
![Home](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2020.08.58.png)
![Search](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2020.08.42.png)

### Lista y detalle
![List](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2019.52.55.png)
![Detail](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2019.52.47.png)
![Card](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2019.52.36.png)

</div>

---

## 🎬 Demostraciones

<div align="center">

### 🏠 Flujo principal de la app
![home_flow.gif](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/home_flow.gif)
*Navegación entre facturas con PageView sincronizado*

### 🔄 Carga de componentes
![charge_components.gif](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/charge_components.gif)
*Animaciones de carga y transiciones visuales*

### 🔐 Flujo de login
![login_flow-1.gif](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/login_flow-1.gif)
*Autenticación con validación y feedback*

### 🌊 Splash Screen
![splash_screen.gif](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/splash_screen.gif)
*Pantalla de bienvenida con verificación inicial*

### 🪆 Empty State
![empty_state.gif](https://github.com/palmerovicdev/invoapp/blob/main/blueprints/empty_state.gif)
*Manejo de estados vacíos con opciones de reintento*

</div>

---

## 🛠️ Tecnologías

### Dependencias principales

| Categoría | Paquetes |
|-----------|----------|
| **Estado** | `flutter_bloc` `bloc` `equatable` |
| **Navegación** | `go_router` |
| **DI** | `get_it` |
| **HTTP** | `dio` |
| **Almacenamiento** | `flutter_secure_storage` |
| **UI/Animaciones** | `animate_do` `flutter_motionly` `animated_text_kit` |
| **Imágenes** | `cached_network_image` |
| **Internacionalización** | `intl` `flutter_localizations` |
| **Configuración** | `envied` |

### Herramientas de desarrollo

- `build_runner` - Generación de código
- `json_serializable` - Serialización JSON
- `freezed` - Inmutabilidad y unions
- `flutter_native_splash` - Splash screen nativo
- `flutter_launcher_icons` - Iconos de la app
- `flutter_lints` - Reglas de linting

---

## ⚙️ Requisitos

- **Flutter** 3.9.2 o superior
- **Dart** 3.9.2 o superior
- **Xcode** (macOS) - Para compilación iOS
- **Android Studio** / Android SDK - Para Android
- **CocoaPods** (iOS)

> 📚 [Guía oficial de instalación de Flutter](https://flutter.dev/docs/get-started/install)

---

## 🚀 Instalación

### 1️⃣ Clonar el repositorio

```bash
git clone https://github.com/palmerovicdev/invoapp.git
cd invoapp
```

### 2️⃣ Instalar dependencias

```bash
flutter pub get
```

### 3️⃣ Generar código

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4️⃣ Ejecutar la aplicación

```bash
flutter run
```

---

## 🍎 Construcción para iOS

```bash
# Instalar dependencias nativas
cd ios
pod install
cd ..

# Compilar
flutter build ios

# O ejecutar directamente
flutter run
```

---

## 🤖 Construcción para Android

```bash
# Compilar
flutter build apk

# O compilar para release
flutter build apk --release

# Para ejecutar
flutter run
```

---

## 🐛 Debugging

### Ver logs en consola

```bash
flutter run
```

### Logs detallados

```bash
flutter run -v
```

### Logs de Android

```bash
adb logcat | grep flutter
```

### Revisar logs de BLoC

La aplicación registra automáticamente todas las transiciones de estado BLoC y errores en la consola.

---

## 📁 Estructura del proyecto

```
lib/
├── core/                    # Configuración central
│   ├── auth_status.dart     # Estados de autenticación
│   ├── locator.dart         # Inyección de dependencias
│   ├── logger.dart          # Sistema de logging
│   ├── route/               # Configuración de rutas
│   ├── theme/               # Tema de la aplicación
│   ├── env/                 # Variables de entorno
│   └── localization/        # Configuración de idiomas
│
├── domain/                  # Lógica de negocio
│   ├── entity/              # Entidades del dominio
│   ├── request/             # Modelos de peticiones
│   └── response/            # Modelos de respuestas
│
├── data/                    # Capa de datos
│   ├── repository/          # Implementación de repositorios
│   └── data/               # Modelos de datos
│
├── presentation/            # Capa de presentación
│   ├── page/               # Páginas principales
│   ├── widget/             # Widgets reutilizables
│   └── state/              # Estados BLoC
│
└── service/                # Servicios
    ├── invoice_service.dart
    └── login_service.dart

assets/                      # Recursos (imágenes, etc.)
blueprints/                  # Diseños y capturas
```

---

## 🏗️ Arquitectura

La aplicación sigue los principios de **Clean Architecture** y **BLoC pattern**:

```
┌─────────────────────────────────────┐
│       Presentation Layer            │
│  (Páginas, Widgets, BLoC States)    │
├─────────────────────────────────────┤
│          Domain Layer               │
│  (Entities, Business Logic)         │
├─────────────────────────────────────┤
│           Data Layer                │
│  (Repositories, Data Sources)      │
└─────────────────────────────────────┘
```

### Flujo de datos

1. **UI** → Dispara eventos al BLoC
2. **BLoC** → Procesa la lógica con el repositorio
3. **Repository** → Consulta datos locales o remotos
4. **BLoC** → Emite nuevos estados
5. **UI** → Se actualiza según el estado

---

## 🤝 Contribución

Las contribuciones son bienvenidas. Para cambios mayores:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

---

<div align="center">

### ⭐ Si este proyecto te ha sido útil, considera darle una estrella

**Desarrollado con ❤️ por [palmerovicdev](https://github.com/palmerovicdev)**

[⬆ Volver arriba](#-invoapp)

</div>
