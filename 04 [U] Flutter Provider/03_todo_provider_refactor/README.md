# todo_provider_refactor

## ChangeNotifierPRovider + ProxyProvider

- StateNotifierProvider
  - Provider pakcage저자인 Remi가 만든 package
  - ProxyProvider를 사용할 필요 없음
  - Riverpod에서 자주 쓰이고 있음
  - StateNotifierProvider에 대한 이해도를 갖추면 향후 Riverpod 이해하는데 도움이 됨

- ActiveTodoCount
  - Depends on TodoList
  - No state of its own

- FilteredTodos
  - Depends on TodoFilter, TodoSearch, TodoList
  - No state of its own

- ProviderManual
  - Prefer using ProxyProvider when possible
    - If the created object is only a combination of other objects, without http calls or similar side-effects, then it is likely that an immutable object built using ProxyProvider will work
    
- Definition of ProxyProvider
  - A provider that builds a value based on other providers
  - The exposed value if build through eighter create or update
  - As opposed to create, update may be called more than once.
    - It will be called once the first time the value is obtained, then once whenever ProxProvider rebuilds or when one of the providers it depends on update