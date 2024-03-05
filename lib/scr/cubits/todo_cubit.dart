import 'package:bloc/bloc.dart';
import 'package:learn_cubit/scr/cubits/todo_states.dart';

class TodoCubit extends Cubit<TodoStates> {
  final List<String> _todos = [];

  TodoCubit() : super(InitialTodoState());
}
