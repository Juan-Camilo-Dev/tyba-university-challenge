# 🎓 Tyba University Explorer

[![Flutter CI](https://github.com/Juan-Camilo-Dev/tyba-university-challenge/actions/workflows/flutter_test.yml/badge.svg)](https://github.com/Juan-Camilo-Dev/tyba-university-challenge/actions)
[![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-green)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![State Management](https://img.shields.io/badge/State-Provider-blue)](https://pub.dev/packages/provider)

Aplicación móvil desarrollada como prueba técnica para el rol de **Frontend Engineer** en Tyba.
El objetivo es demostrar una arquitectura robusta, escalable y testeable, implementando funcionalidades de listado, detalle y persistencia local de estado.

---

## 📱 Capturas de Pantalla

|                              Lista de Universidades                              | Vista en Cuadrícula (Grid) | Detalle y Edición |
|:--------------------------------------------------------------------------------:|:---:|:-----------------:|
| <img src="https://github.com/user-attachments/assets/1cae9247-e545-4860-9bdd-3729d9810dfe" width="250"> | <img src="https://github.com/user-attachments/assets/06abb42e-2b2a-4bfe-aed5-53bd38c6751b" width="250"> |   <img src="https://github.com/user-attachments/assets/4f2f959c-eab0-486e-a2e6-d5f34a85c678" width="250">    |

---

## 🚀 Características Principales

- **Arquitectura Limpia (Clean Architecture):** Separación estricta de responsabilidades en capas (Domain, Data, Presentation).
- **Inyección de Dependencias:** Uso de `GetIt` para desacoplar componentes y facilitar el testing.
- **Gestión de Estado:** Implementación reactiva con `Provider`.
- **Diseño Adaptativo:** Cambio dinámico entre `ListView` y `GridView` con layouts optimizados para cada vista.
- **Infinite Scroll:** Paginación local implementada manualmente (Bono completado).
- **Manejo de Errores:** Mapeo de excepciones a `Failures` de dominio.
- **Unit Testing:** Cobertura de pruebas para la lógica de negocio (UseCases y Providers) usando `Mocktail`.

## 🛠 Tech Stack

* **Lenguaje:** Dart 3.x
* **Framework:** Flutter 3.x
* **Networking:** Dio (con interceptores y manejo de timeouts).
* **Core:** Equatable (para comparación por valor).
* **Native Features:** Image Picker (Cámara y Galería).
* **Testing:** Flutter Test & Mocktail.

## 📂 Estructura del Proyecto

El proyecto sigue una estructura modular basada en "Features" y capas:

```text
lib/
├── core/
│   ├── constants/         # URLs y configuraciones estáticas
│   ├── errors/            # Definición de Failures y Excepciones
│   └── usecases/          # Clase base para casos de uso (UseCase)
├── data/                  # Capa de Datos
│   ├── datasources/       # Fuentes de datos (API Remota)
│   ├── models/            # Modelos de datos (parseo JSON)
│   └── repositories/      # Implementación de repositorios
├── domain/                # Capa de Dominio (Pura dart)
│   ├── entities/          # Objetos de negocio
│   ├── repositories/      # Contratos (Interfaces)
│   └── usecases/          # Lógica de negocio encapsulada
├── presentation/          # Capa de UI
│   ├── providers/         # State Management
│   ├── screens/           # Pantallas
│   └── widgets/           # Componentes reusables
└── main.dart              # Entry Point e Inyección de Dependencias
```

---

## ✅ Cómo ejecutar el proyecto

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/TU_USUARIO/tyba-university-challenge.git](https://github.com/TU_USUARIO/tyba-university-challenge.git)
2. **Instalar dependencias:**
    ```bash
   flutter pub get
3. **Ejecutar Tests (Opcional pero recomendado):**
    ```bash
   flutter test
4. **Correr la aplicación:**
    ```bash
   flutter run

---

## 💡 Decisiones Técnicas

1.  **¿Por qué Clean Architecture?** Para garantizar que la lógica de negocio sea independiente de la UI y de frameworks externos. Esto permite, por ejemplo, cambiar la API por una base de datos local sin tocar una sola línea de la UI.
2.  **Manejo de Estado (Provider):** Se eligió Provider por ser robusto, ligero y estándar en la comunidad, evitando el boilerplate excesivo de otras soluciones para el alcance de esta prueba.
3.  **Tests Unitarios:** Se priorizó el testeo de la capa de presentación lógica (UniversityProvider) y dominio, simulando el comportamiento de la API con Mocks para asegurar la estabilidad del flujo de datos.

---

## Desarrollado con ❤️ y buenas prácticas de ingeniería.