import 'package:speak_up/models/chat_message_model.dart';

abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class AiChatMessageUpdated extends AiChatState {
  final List<ChatMessage> messages;
  AiChatMessageUpdated({required this.messages});
}

class AiChatTyping extends AiChatState {}
