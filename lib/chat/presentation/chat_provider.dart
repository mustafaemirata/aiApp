import 'package:aitutorial/chat/data/gemini_service.dart';
import 'package:aitutorial/chat/model/message.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final GeminiService _apiService = GeminiService();
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String content) async {
    if (content.isEmpty) return;

    // Kullanıcı mesajını ekle
    final userMessage = Message(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _messages.add(userMessage);
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    try {
      // 🔹 sendMessage yerine sendPrompt kullanıyoruz
      final response = await _apiService.sendPrompt(content);

      final responseMessage = Message(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(responseMessage);
    } catch (e) {
      final errorMessage = Message(
        content: 'Error: $e',
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
