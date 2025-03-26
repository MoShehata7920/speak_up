import 'package:bloc/bloc.dart';
import 'package:speak_up/models/chat_message_model.dart';
import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit() : super(AiChatInitial());

  final List<ChatMessage> messages = [];

  void sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    messages.add(ChatMessage(message: message, isUser: true));
    emit(AiChatMessageUpdated(messages: List.from(messages)));

    emit(AiChatTyping());
    await Future.delayed(const Duration(seconds: 2));

    messages.add(
      ChatMessage(message: "AI Response for: $message", isUser: false),
    );
    emit(AiChatMessageUpdated(messages: List.from(messages)));
  }

  void regenerateResponse() async {
    emit(AiChatTyping());
    await Future.delayed(const Duration(seconds: 2));
    messages.removeLast();
    messages.add(
      ChatMessage(message: "Regenerated AI Response", isUser: false),
    );
    emit(AiChatMessageUpdated(messages: List.from(messages)));
  }
}
