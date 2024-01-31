import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Counter App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  SnackBar(
                    backgroundColor: Colors.black,
                    content: Text("Incremented!"),
                    duration: Duration(microseconds: 300),
                  );
                } else if (state.wasIncremented == false) {
                  SnackBar(
                    backgroundColor: Colors.black,
                    content: Text("Decremented!"),
                    duration: Duration(microseconds: 300),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
              // context.bloc<CounterCubit>().decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
