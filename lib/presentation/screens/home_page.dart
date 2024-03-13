import 'package:counter_app/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:counter_app/presentation/blocs/counter_bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    Text(
                      'Weather: ${state.weather}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'You have pushed the button this many times: ${state.count}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () =>
                      context.read<CounterBloc>().add(Increment()),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () =>
                      context.read<CounterBloc>().add(Decrement()),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () =>
                      context.read<CounterBloc>().add(GethWeather()),
                  tooltip: 'Get Weather',
                  child: const Icon(Icons.cloud),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
