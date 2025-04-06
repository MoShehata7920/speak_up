import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String? fullName;
  final String? profileImage;

  const HomeState({this.fullName, this.profileImage});

  HomeState copyWith({String? fullName, String? profileImage}) {
    return HomeState(
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [fullName, profileImage];
}
