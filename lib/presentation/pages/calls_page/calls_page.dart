import 'package:flutter/material.dart';
import '../../../common/utils/palette.dart';
import 'widgets/single_item_call_page.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return const SingleItemCallPage();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor:  Palette.primaryColor,
        child: const Icon(Icons.add_call,color: Colors.white,),
      ),
    );
  }
}
