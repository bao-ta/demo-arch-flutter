import 'package:clean_architecture_demo/features/number_trivia/domain/entities/number_trival.dart';
import 'package:clean_architecture_demo/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  NumberTriviaPage({super.key});
  TextEditingController textEditingController = TextEditingController();
  String input = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Number Trivia',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocProvider<NumberTriviaBloc>(
        create: (context) => sl<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is EmptyNumber) {
                    return const Text(
                      'Start Searching',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    );
                  }
                  if (state is Loading) {
                    return const Column(
                      children: [
                        Text(
                          'Getting contents for number',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                  if (state is Loaded) {
                    return Column(
                      children: [
                        Text('${state.trivia.number}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                        Text(
                          state.trivia.text,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    );
                  }
                  if (state is Error) {
                    return Column(
                      children: [
                        Text(
                          state.message,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onSubmitted: (value) {
                  textEditingController.text = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  hintText: 'Enter a Number',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: SizedBox(
                          width: 180,
                          child:
                              ElevatedButton(style: const ButtonStyle(), onPressed: () {
                                dispatchConcrete(context);
                                textEditingController.clear();
                              }, child: const Text('OK')))),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      flex: 1,
                      child: SizedBox(
                          width: 180,
                          child: ElevatedButton(
                            style:
                                ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple.shade400)),
                            onPressed: () {},
                            child: const Text(
                              'Random number',
                              style: TextStyle(color: Colors.white),
                            ),
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  dispatchConcrete(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context).getConcreteNumberUseCase(int.parse(textEditingController.text));
  }
}
