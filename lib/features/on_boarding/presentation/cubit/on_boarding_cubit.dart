import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void updatePage(int index) => emit(index);

  bool isLastPage() => state == 2;
}
