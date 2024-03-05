import 'package:bloc/bloc.dart';
import 'package:learn_cubit/scr/cubits/todo_states.dart';

class TodoCubit extends Cubit<TodoStates> {
  final List<String> _todos = [];

  List<String> get todos => _todos;

  TodoCubit() : super(InitialTodoState());

  Future<void> addTodo({required String todo}) async {
    emit(LoadingTodoState());

    await Future.delayed(const Duration(milliseconds: 100));

    if (_todos.contains(todo)) {
      emit(ErrorTodoState(message: 'Todo already on the list'));
    } else {
      _todos.add(todo);
      emit(DoneTodoState(todos: _todos));
    }
  }

  removeTodo({required int index}) async {
    emit(LoadingTodoState());

    await Future.delayed(const Duration(milliseconds: 100));

    _todos.removeAt(index);

    emit(DoneTodoState(todos: _todos));
  }
}
