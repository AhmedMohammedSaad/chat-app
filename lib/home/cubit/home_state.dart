part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class GetChatLoading extends HomeState {}

final class GetChatSuccess extends HomeState {
  final List<ChatItemModel> chats;
  final String? imageUrl;

  GetChatSuccess({required this.chats, this.imageUrl});
}

final class GetChatFailure extends HomeState {
  final String errorMessage;

  GetChatFailure({required this.errorMessage});
}
