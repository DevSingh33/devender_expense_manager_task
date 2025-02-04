# Details

Date : 2025-02-04 22:37:57

Directory /Users/devsingh/projects/exp/devender_expense_manager_task/lib

Total : 34 files,  1691 codes, 71 comments, 269 blanks, all 2031 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/core/error/failures.dart](/lib/core/error/failures.dart) | Dart | 10 | 1 | 6 | 17 |
| [lib/core/init/hive\_init.dart](/lib/core/init/hive_init.dart) | Dart | 10 | 1 | 4 | 15 |
| [lib/core/init/notification\_init.dart](/lib/core/init/notification_init.dart) | Dart | 106 | 9 | 16 | 131 |
| [lib/core/logging/logging.dart](/lib/core/logging/logging.dart) | Dart | 7 | 1 | 2 | 10 |
| [lib/features/expense/data/datasources/expense\_local\_datasource.dart](/lib/features/expense/data/datasources/expense_local_datasource.dart) | Dart | 7 | 4 | 4 | 15 |
| [lib/features/expense/data/expense\_hive\_datasource.dart](/lib/features/expense/data/expense_hive_datasource.dart) | Dart | 73 | 0 | 15 | 88 |
| [lib/features/expense/data/expense\_hive\_datasource.g.dart](/lib/features/expense/data/expense_hive_datasource.g.dart) | Dart | 42 | 4 | 8 | 54 |
| [lib/features/expense/data/models/expense\_model.dart](/lib/features/expense/data/models/expense_model.dart) | Dart | 33 | 2 | 5 | 40 |
| [lib/features/expense/data/models/expense\_summary\_modal.dart](/lib/features/expense/data/models/expense_summary_modal.dart) | Dart | 33 | 2 | 6 | 41 |
| [lib/features/expense/data/repositories/expense\_repository\_impl.dart](/lib/features/expense/data/repositories/expense_repository_impl.dart) | Dart | 160 | 6 | 25 | 191 |
| [lib/features/expense/domain/entities/expense.dart](/lib/features/expense/domain/entities/expense.dart) | Dart | 14 | 0 | 2 | 16 |
| [lib/features/expense/domain/entities/expense\_summary.dart](/lib/features/expense/domain/entities/expense_summary.dart) | Dart | 14 | 0 | 3 | 17 |
| [lib/features/expense/domain/repositories/expense\_repository.dart](/lib/features/expense/domain/repositories/expense_repository.dart) | Dart | 12 | 5 | 6 | 23 |
| [lib/features/expense/domain/usecases/add\_expense.dart](/lib/features/expense/domain/usecases/add_expense.dart) | Dart | 20 | 2 | 8 | 30 |
| [lib/features/expense/domain/usecases/delete\_expense.dart](/lib/features/expense/domain/usecases/delete_expense.dart) | Dart | 19 | 2 | 7 | 28 |
| [lib/features/expense/domain/usecases/get\_expense.dart](/lib/features/expense/domain/usecases/get_expense.dart) | Dart | 13 | 1 | 4 | 18 |
| [lib/features/expense/domain/usecases/get\_expense\_summary.dart](/lib/features/expense/domain/usecases/get_expense_summary.dart) | Dart | 21 | 2 | 8 | 31 |
| [lib/features/expense/domain/usecases/update\_expense.dart](/lib/features/expense/domain/usecases/update_expense.dart) | Dart | 20 | 2 | 8 | 30 |
| [lib/features/expense/presentation/blocs/expense\_bloc/expense\_bloc.dart](/lib/features/expense/presentation/blocs/expense_bloc/expense_bloc.dart) | Dart | 105 | 0 | 8 | 113 |
| [lib/features/expense/presentation/blocs/expense\_bloc/expense\_event.dart](/lib/features/expense/presentation/blocs/expense_bloc/expense_event.dart) | Dart | 19 | 0 | 5 | 24 |
| [lib/features/expense/presentation/blocs/expense\_bloc/expense\_state.dart](/lib/features/expense/presentation/blocs/expense_bloc/expense_state.dart) | Dart | 16 | 0 | 8 | 24 |
| [lib/features/expense/presentation/blocs/expense\_summary\_bloc/expense\_summary\_bloc.dart](/lib/features/expense/presentation/blocs/expense_summary_bloc/expense_summary_bloc.dart) | Dart | 27 | 3 | 6 | 36 |
| [lib/features/expense/presentation/blocs/expense\_summary\_bloc/expense\_summary\_event.dart](/lib/features/expense/presentation/blocs/expense_summary_bloc/expense_summary_event.dart) | Dart | 16 | 0 | 5 | 21 |
| [lib/features/expense/presentation/blocs/expense\_summary\_bloc/expense\_summary\_state.dart](/lib/features/expense/presentation/blocs/expense_summary_bloc/expense_summary_state.dart) | Dart | 20 | 0 | 11 | 31 |
| [lib/features/expense/presentation/pages/home\_page.dart](/lib/features/expense/presentation/pages/home_page.dart) | Dart | 43 | 0 | 5 | 48 |
| [lib/features/expense/presentation/screens/add\_expense\_screen.dart](/lib/features/expense/presentation/screens/add_expense_screen.dart) | Dart | 148 | 0 | 11 | 159 |
| [lib/features/expense/presentation/screens/expense\_list\_screen.dart](/lib/features/expense/presentation/screens/expense_list_screen.dart) | Dart | 112 | 2 | 5 | 119 |
| [lib/features/expense/presentation/screens/expense\_summary\_screen.dart](/lib/features/expense/presentation/screens/expense_summary_screen.dart) | Dart | 46 | 1 | 6 | 53 |
| [lib/features/expense/presentation/widgets/expense\_list\_item.dart](/lib/features/expense/presentation/widgets/expense_list_item.dart) | Dart | 59 | 0 | 5 | 64 |
| [lib/features/expense/presentation/widgets/expense\_pie\_chart.dart](/lib/features/expense/presentation/widgets/expense_pie_chart.dart) | Dart | 290 | 14 | 34 | 338 |
| [lib/features/expense/presentation/widgets/summary\_category\_item.dart](/lib/features/expense/presentation/widgets/summary_category_item.dart) | Dart | 87 | 0 | 7 | 94 |
| [lib/injection\_container.dart](/lib/injection_container.dart) | Dart | 43 | 5 | 7 | 55 |
| [lib/main.dart](/lib/main.dart) | Dart | 36 | 1 | 8 | 45 |
| [lib/usecases/usecase.dart](/lib/usecases/usecase.dart) | Dart | 10 | 1 | 1 | 12 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)