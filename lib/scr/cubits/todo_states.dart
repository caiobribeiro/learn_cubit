abstract class TodoStates {}

class InitialTodoState extends TodoStates {}

class LoadingTodoState extends TodoStates {}

class DoneTodoState extends TodoStates {
  final List<String> todos;

  DoneTodoState({required this.todos});
}

class ErrorTodoState extends TodoStates {
  final String message;

  ErrorTodoState({required this.message});
}
