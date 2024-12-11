import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_index_state.dart';

class TabIndexCubit extends Cubit<TabIndexState> {
  TabIndexCubit() : super(TabIndexInitial(List.generate(100, (_) => null)));

  void trueAnswer(int index) {
    if (state is TabIndexInitial) {
      // Create a new list based on the current state
      final currentState = (state as TabIndexInitial).tabStates;
      final updatedList = List<bool?>.from(currentState);

      // Update the list at the specified index
      updatedList[index] = true;

      // Emit the new state
      emit(TabIndexInitial(updatedList));
    }
  }

  void falseAnswer(int index) {
    if (state is TabIndexInitial) {
      // Create a new list based on the current state
      final currentState = (state as TabIndexInitial).tabStates;
      final updatedList = List<bool?>.from(currentState);

      // Update the list at the specified index
      updatedList[index] = false;

      // Emit the new state
      emit(TabIndexInitial(updatedList));
    }
  }

  void selectAnswer(int questionIndex, bool isCorrect) {
    final updatedStates =
        List<bool?>.from((state as TabIndexInitial).tabStates);
    updatedStates[questionIndex] = isCorrect;
    emit(TabIndexInitial(updatedStates));
  }

  void updateState() {
    if (state is TabIndexInitial) {
      // Get the current state
      final currentState = (state as TabIndexInitial).tabStates;

      // Create a new list where all 'null' values are set to 'false'
      final updatedList = currentState.map((tabState) {
        return tabState = null; // Set 'null' values to 'false'
      }).toList();

      // Emit the updated state
      emit(TabIndexInitial(updatedList));
    }
  }
}
