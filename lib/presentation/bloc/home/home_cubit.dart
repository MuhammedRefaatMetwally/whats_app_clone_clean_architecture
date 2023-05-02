import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
 static HomeCubit i(BuildContext context)=>BlocProvider.of(context);
  bool isSearch = false;

  int currentPageIndex = 1;

  void onSearching(){
    isSearch=true;
    emit(HomeSearchingState());
  }
  void notSearching(){
    isSearch=false;
    emit(NotSearchingState());
  }
  void onPageChanged(int index){
    currentPageIndex=index;
    emit(HomeChangePageIndexState());
  }
}
