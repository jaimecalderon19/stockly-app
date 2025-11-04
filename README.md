# 🛍️ Stockly – Gestión de productos con Flutter + Cubit

**Stockly** es una aplicación móvil desarrollada en **Flutter** que permite gestionar una lista de productos obtenidos desde la **[Fake Store API](https://fakestoreapi.com/)**.  
El usuario puede consultar los productos, guardarlos localmente con nombres personalizados, editarlos o eliminarlos, y visualizar los detalles de cada uno.

---

## 📱 Características principales

- 🔄 **Consumo de API pública** (Fake Store API)
- 💾 **Persistencia local** con Hive
- 🧠 **Gestión de estado** usando Cubit (parte de BLoC)
- 🧩 **Arquitectura limpia y modular**
- 💬 **Interfaz intuitiva**, responsive y con manejo de estados (`loading`, `success`, `error`)
- 🔍 **Buscador en tiempo real**
- 🛠️ **Operaciones CRUD** completas sobre los productos guardados localmente

---

## 🧭 Navegación principal

| Ruta | Descripción |
|------|--------------|
| `/api-list` | Lista de productos obtenidos desde la API |
| `/prefs` | Lista de productos guardados localmente |
| `/prefs/new` | Crear nuevo producto guardado |
| `/prefs/:id` | Detalle de un producto guardado |

---

## 🖼️ Pantallas incluidas

1. **Listado de productos de la API**  
   - Muestra todos los productos con imagen, nombre y precio.  
   - Incluye buscador y estados visuales (carga/error).

2. **Agregar producto local**  
   - Selector para elegir producto desde la API.  
   - Campo para nombre personalizado y botones *Guardar* / *Cancelar*.

3. **Lista de productos guardados**  
   - Ver todos los productos almacenados en Hive.  
   - Posibilidad de eliminar cada uno.

4. **Detalle de producto**  
   - Ver imagen, nombre personalizado, descripción y precio.  
   - Opción para eliminar o regresar.

5. **Pantallas globales de carga y error.**

---

## ⚙️ Tecnologías utilizadas

- **Flutter** 3.x  
- **Dart** (Null Safety)
- **Cubit / BLoC** para gestión de estado  
- **Hive** para persistencia local  
- **Dio** o **http** para consumo de API  
- **GoRouter** para navegación  
- **Material Design 3** para UI

---

## 🧩 Estructura del proyecto

```bash
lib/
├── main.dart
├── core/
│   ├── models/
│   ├── services/
│   └── utils/
├── data/
│   ├── local/        # Hive DB, adapters
│   ├── remote/       # API service
│   └── repositories/ # Interfaces de datos
├── logic/
│   ├── cubits/
│   │   ├── api_cubit/
│   │   └── prefs_cubit/
│   └── states/
├── presentation/
│   ├── screens/
│   │   ├── api_list/
│   │   ├── prefs_list/
│   │   ├── prefs_new/
│   │   └── prefs_detail/
│   └── widgets/
└── routes/
    └── app_router.dart
