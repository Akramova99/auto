part of 'tab_index_cubit.dart';

@immutable
sealed class TabIndexState {}

final class TabIndexInitial extends TabIndexState {
  final List<bool?> tabStates ;
  TabIndexInitial(this.tabStates);
}
