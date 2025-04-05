import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationCubit extends Cubit<List<Map<String, dynamic>>> {
  ConversationCubit()
    : super([
        {"text": "Hello! How can I assist you?", "isUser": false},
        {"text": "How do I say 'Good morning' in French?", "isUser": true},
        {"text": "You can say 'Bonjour'!", "isUser": false},
      ]);

  bool isTyping = false;

  void sendMessage(String message) {
    if (message.trim().isEmpty) return;

    final updatedMessages = List<Map<String, dynamic>>.from(state)
      ..add({"text": message.trim(), "isUser": true});

    emit(updatedMessages);

    _simulateAIResponse();
  }

  void _simulateAIResponse() async {
    isTyping = true;
    emit(List<Map<String, dynamic>>.from(state));

    await Future.delayed(const Duration(seconds: 2));

    final updatedMessages = List<Map<String, dynamic>>.from(state)
      ..add({"text": "That's an interesting question!", "isUser": false});

    isTyping = false;
    emit(updatedMessages);
  }
}
