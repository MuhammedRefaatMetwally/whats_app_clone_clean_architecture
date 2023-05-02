import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import '../../../bloc/home/home_cubit.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit=HomeCubit.i(context);
        return Container(
          height: 45,
          margin: const EdgeInsets.only(top: 25),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                spreadRadius: 1,
                offset: const Offset(0.0, 0.50))
          ]),
          child: TextField(
            decoration: InputDecoration(
              hintText: AppConst.searching,
              prefixIcon: InkWell(
                onTap: () => cubit.onSearching(),
                child: GestureDetector(onTap:()=> cubit.notSearching(),
                child: const Icon(Icons.arrow_back)),
              ),
            ),
          ),
        );
      },
    );
  }
}
