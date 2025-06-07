# App Dogs

Prueba Técnica - App Dogs

# Descripción
Esta aplicación iOS es una demostración técnica que muestra información de listado de perros API de jsonblob.
El proyecto implementa principios de Clean Architecture con el patrón mvvm, enfatizando la calidad del código, la capacidad de prueba y la mantenibilidad.

# Especificaciones Técnicas

- Plataforma: iOS 15.6+
- Lenguaje: Swift 5
- Framework UI: SwiftUI
- Arquitectura: Clean Architecture + mvvm
- SwiftData persistencia de datos 
- UrlSession peticiones http
- Userdefault persistencia basica
- Inyección de Dependencias: Contenedor DI personalizado, Resolver

# Arquitectura

Clean Architecture con el patron arquitectonico mvvm

- Capa de Datos: Maneja operaciones de datos y servicios externos
- Capa de Dominio: Contiene la lógica de negocio y entidades
- Capa de Presentación: Implementa módulos mvvm y componentes UI

# Implementación MVVM

- Vista: Maneja elementos UI e interacciones del usuario
- Use case: Contiene lógica de negocio
- ViewModel: Gestiona la lógica de la Vista y el formato de datos
- Entidad: Representa modelos de datos

# Características

- Vista Dogs

# Dependencias

- Resolver
- SkeletonUI

# Estrategia de Pruebas

- Pruebas Unitarias (XCTest)
- Cobertura completa para todos los modulos 

# Cobertura de Código
  
  Cobertura general: 87.6%
![Screenshot 2025-06-07 at 2 49 30 PM](https://github.com/user-attachments/assets/f0388228-ad18-4778-9d0a-eb20bd61a22c)


# Instrucciones de Instalación

1. Clonar el repositorio
2. Abrir el proyecto interTest.xcodeproj
3. Esperar que se descargen las dependencias de spm
4. Compilar y ejecutar

# Ejecución de Pruebas

1. Abrir el proyecto AppDogs.xcodeproj
2. Seleccionar el esquema de pruebas AppDogsTestTests
3. Presionar Cmd + U para ejecutar las pruebas
4. Ver el informe de cobertura en Xcode

# Prácticas de Desarrollo

- Implementación de principios SOLID
- Inyección de Dependencias para mejor capacidad de prueba
- Programación orientada a protocolos
- Arquitectura modular (Mvvm + Clean Arquitecture)
- Inyeccion de dependencias
- POO
- Vistas con SwiftUi y NavigationStack 

# PrintScreen App
![Simulator Screenshot - iPhone 16 Pro Max - 2025-06-07 at 14 54 31](https://github.com/user-attachments/assets/3e55eed3-118a-4e77-b84c-b7b061fc2d0c)


