import 'package:speak_up/features/ai_chat/data/chat_message_model.dart';

abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class AiChatMessageUpdated extends AiChatState {
  final List<ChatMessage> messages;
  AiChatMessageUpdated({required this.messages});
}

class AiChatTyping extends AiChatState {}
