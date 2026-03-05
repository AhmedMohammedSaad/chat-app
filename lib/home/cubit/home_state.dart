part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class GetChatLoading extends HomeState {}

final class GetChatSuccess extends HomeState {
  final List<ChatItemModel> chats;

  GetChatSuccess({required this.chats});
}

final class GetChatFailure extends HomeState {
  final String errorMessage;

  GetChatFailure({required this.errorMessage});
}
