import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_cubit/scr/cubits/todo_cubit.dart';
import 'package:learn_cubit/scr/cubits/todo_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TodoCubit cubit;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TodoCubit>(context);
    cubit.stream.listen((state) {
      if (state is ErrorTodoState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo with Cubit'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is InitialTodoState) {
                      return const Text('Empty list');
                    } else if (state is LoadingTodoState) {
                      return const CircularProgressIndicator();
                    } else if (state is DoneTodoState) {
                      return _buildTodoList(state.todos);
                    } else {
                      return _buildTodoList(cubit.todos);
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -5),
                  blurRadius: 4,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.addTodo(todo: _textEditingController.text);
                      _textEditingController.clear();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(List<String> todos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: Text(todos[index][0]),
        ),
        title: Text(
          todos[index],
        ),
        trailing: IconButton(
          onPressed: () {
            cubit.removeTodo(index: index);
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
