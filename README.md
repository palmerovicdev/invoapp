# 🧾 InvoApp

Aplicación de **listado de facturas (Flutter)** — interfaz de ejemplo con navegación, búsqueda, filtros por fecha y paginación.

<p align="center">
  <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2020.08.58.png" width="80%" alt="Pantalla principal">
</p>

---

## 🧩 Descripción

**InvoApp** es una aplicación móvil construida con Flutter que muestra facturas, permite buscar, filtrar por fechas, navegar entre facturas y cargar páginas adicionales al llegar al final de la lista.

---

## ✨ Características destacadas

- 🔄 PageView sincronizado con una lista inferior y selección de items.  
- 🔍 Búsqueda con debounce y limpieza de filtros.  
- 📅 Filtro por fechas con diálogo y acciones rápidas (últimos 7/30 días, mes actual).  
- 🎨 Temas y personalización visual (colores, cursor, tamaños, etc.).  

---

## 📱 Capturas

<p align="center">
  <b>Pantallas principales</b>
</p>

<p align="center">
  <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2020.08.58.png" width="30%" alt="Principal">
  <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2020.08.42.png" width="30%" alt="Navegación y búsqueda">
  <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2019.52.55.png" width="30%" alt="Lista de facturas">
</p>

<p align="center">
  <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2019.52.47.png" width="30%" alt="Filtro por fecha">
  <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/Screenshot%202025-10-28%20at%2019.52.36.png" width="30%" alt="Detalle / tarjeta">
</p>

---

<!-- GIFs section inserted as HTML as requested -->

## 🎬 GIFs (demostraciones)

<div style="display:flex;flex-direction:column;gap:24px;align-items:center;">
  <figure style="max-width:900px;margin:0;">
    <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/charge_components.gif" alt="Charge components" style="width:100%;height:auto;border-radius:8px;" />
    <figcaption style="text-align:left;margin-top:8px;color:#444;"><strong>charge_components.gif</strong> — Animación de los componentes de home mostrando interacciones, estados y transiciones visuales.</figcaption>
  </figure>

  <figure style="max-width:900px;margin:0;">
    <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/home_flow.gif" alt="Home flow" style="width:100%;height:auto;border-radius:8px;" />
    <figcaption style="text-align:left;margin-top:8px;color:#444;"><strong>home_flow.gif</strong> — Flujo principal: cambio de selección y transiciones del PageView.</figcaption>
  </figure>

  <figure style="max-width:900px;margin:0;">
    <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/login_flow-1.gif" alt="Login flow" style="width:100%;height:auto;border-radius:8px;" />
    <figcaption style="text-align:left;margin-top:8px;color:#444;"><strong>login_flow-1.gif</strong> — Flujo de inicio de sesión: entrada de credenciales y login</figcaption>
  </figure>

  <figure style="max-width:900px;margin:0;">
    <img src="https://github.com/palmerovicdev/invoapp/blob/main/blueprints/splash_screen.gif" alt="Splash screen" style="width:100%;height:auto;border-radius:8px;" />
    <figcaption style="text-align:left;margin-top:8px;color:#444;"><strong>splash_screen.gif</strong> — Splash screen de checking account y la animación de transición al inicio de la aplicación.</figcaption>
  </figure>
</div>

---

## ⚙️ Requisitos

- Flutter 3.0+ (recomendado).  
  [Guía de instalación oficial](https://flutter.dev/docs/get-started/install)  
- Xcode (macOS) para construir en iOS.  
- Android SDK / Android Studio para Android.  

---

## 🚀 Instalación y ejecución

1. Clona el repositorio y entra en la carpeta del proyecto:

   ```bash
   git clone https://github.com/palmerovicdev/invoapp.git
   cd invoapp
   ```

2. Instala dependencias:

   ```bash
   flutter pub get
   ```

3. Genera ficheros necesarios:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Ejecuta la app:

   ```bash
   flutter run
   ```

---

## 🍏 Construcción iOS

Si vas a compilar para iOS desde macOS:

```bash
cd ios
pod install
cd ..
flutter build ios
```

---

## 🪵 Dónde mirar logs

- Ejecuta la app con `flutter run` y revisa la consola: los **BLoC** registran información útil para debugging.  
- Para salida más detallada:  
  ```bash
  flutter run -v
  ```
  o  
  ```bash
  adb logcat
  ```

---

## 🧱 Estructura del proyecto (resumen)

```
lib/
 ├── presentation/   # Vistas, widgets y páginas
 ├── domain/         # Entidades y modelos
 ├── data/           # Repositorios / servicios API
 ├── core/           # Utilidades, tema y localización
assets/
ios/
android/
blueprints/          # Capturas y diseños de referencia
```

---

<p align="center">
  <sub>🛠️ Desarrollado con ❤️ en Flutter por <a href="https://github.com/palmerovicdev">palmerovicdev</a></sub>
</p>
