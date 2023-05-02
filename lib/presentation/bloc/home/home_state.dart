part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeSearchingState extends HomeState {}
class NotSearchingState extends HomeState {}
class HomeChangePageIndexState extends HomeState {}
