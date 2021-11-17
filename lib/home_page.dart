import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/providers/categories_provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  void getCategories() async {
    await ref.read(categoriesProvider).getCategories();
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).category;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example Riverpod')),
        body: Column(
          children: [
            Expanded(
              child: categories.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.network(
                              categories[index].image,
                              width: double.infinity,
                              height: 200,
                            ),
                            Text(
                              categories[index].name,
                              style: const TextStyle(fontSize: 30),
                            )
                          ],
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
