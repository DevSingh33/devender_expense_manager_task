# devender_expense_manager_task

A Minimal Expense Tracker App Following Clean Architecture.

## Getting Started
Project Overview:
This project implements a robust Flutter application using Clean Architecture principles, providing a scalable and maintainable solution for expense tracking.

Reference: https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/

Architecture Overview
Clean Architecture Layers
The project is structured feature-wise and each feature has three primary layers:

1.Presentation Layer

Responsible for UI and user interactions
Contains Screens, Widgets, and BLoC (Business Logic Component) for state management
Located in lib/features/[feature]/presentation/


2.Domain Layer

Contains core business logic and entities
Defines interfaces for repositories and use cases
Independent of frameworks and external dependencies
Located in lib/features/[feature]/domain/


3.Data Layer

Implements data sources and repositories
Handles data fetching, caching, and transformation
Located in lib/features/[feature]/data/



Additional Layers

Core Layer: Shared utilities, configurations, and cross-cutting concerns
Dependency Injection: Centralized dependency management

Key Components
Dependency Injection

Implemented using get_it package
Centralized configuration in core/dependency_injection/injection_container.dart
Manages service and repository registrations and for any services dependencies

State Management

Uses BLoC (Business Logic Component) pattern
Separates business logic from UI
Provides clean, predictable state management

Local Storage

Uses Hive for efficient local data persistence
Implemented with type-safe models
Initialized in core/init/hive_init.dart

Whole Project Structure

```
lib
├── core
│   ├── error
│   │   └── failures.dart
│   ├── init
│   │   ├── hive_init.dart
│   │   ├── injection_container.dart
│   │   └── notification_init.dart
│   ├── logging
│   │   └── logging.dart
│   └── theme
│       ├── app_theme.dart
│       └── theme
├── features
│   └── expense
│       ├── data
│       │   ├── datasources
│       │   │   ├── expense_hive_datasource.dart
│       │   │   ├── expense_hive_datasource.g.dart
│       │   │   ├── expense_local_datasource.dart
│       │   │   └── models
│       │   │       ├── expense_model.dart
│       │   │       └── expense_summary_modal.dart
│       │   └── repositories
│       │       └── expense_repository_impl.dart
│       ├── domain
│       │   ├── entities
│       │   │   ├── expense.dart
│       │   │   └── expense_summary.dart
│       │   ├── repositories
│       │   │   └── expense_repository.dart
│       │   └── usecases
│       │       ├── add_expense.dart
│       │       ├── delete_expense.dart
│       │       ├── get_expense.dart
│       │       ├── get_expense_summary.dart
│       │       └── update_expense.dart
│       └── presentation
│           ├── blocs
│           │   ├── expense_bloc
│           │   │   ├── expense_bloc.dart
│           │   │   ├── expense_event.dart
│           │   │   └── expense_state.dart
│           │   └── expense_summary_bloc
│           │       ├── expense_summary_bloc.dart
│           │       ├── expense_summary_event.dart
│           │       └── expense_summary_state.dart
│           ├── pages
│           │   └── home_page.dart
│           ├── screens
│           │   ├── add_expense_screen.dart
│           │   ├── expense_list_screen.dart
│           │   └── expense_summary_screen.dart
│           └── widgets
│               ├── expense_list_item.dart
│               ├── expense_pie_chart.dart
│               └── summary_category_item.dart
├── main.dart
└── usecases
    └── usecase.dart

```

Getting Started

Prerequisites

Flutter SDK

Installation

1. You can test the apk directly,found in apk folder
            or
2. Clone the repository
Run flutter pub get
Generate required files: flutter pub run build_runner build
Run the app:  flutter run

Running Tests
cmd - flutter test 