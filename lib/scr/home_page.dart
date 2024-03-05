import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_cubit/scr/cubits/todo_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TodoCubit cubit;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TodoCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo with Cubit'),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
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
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textEditingController,
                      ),
                    ),
                    IconButton(
                      onPressed: textEditingController.clear,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
