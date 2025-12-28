import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/ai_service.dart';
import '../providers/schedule_provider.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final AIService _aiService = AIService();
  bool _isLoading = false;
  
  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  
  ChatProvider() {
    _addWelcomeMessage();
  }
  
  void _addWelcomeMessage() {
    _messages.add(ChatMessage.ai(
      '👋 Halo! Saya asisten AI Anda untuk membantu mengoptimalkan rutinitas harian Anda.\n\n'
      'Saya dapat membantu:\n'
      '• Menganalisis efektivitas jadwal Anda\n'
      '• Memberikan saran untuk produktivitas\n'
      '• Rekomendasi waktu terbaik untuk aktivitas\n'
      '• Tips manajemen waktu\n\n'
      'Silakan tanyakan apa saja! 😊',
      type: MessageType.text,
    ));
  }
  
  Future<void> sendMessage(String userMessage, ScheduleProvider scheduleProvider) async {
    if (userMessage.trim().isEmpty) return;
    
    // Add user message
    final message = ChatMessage.user(userMessage);
    _messages.add(message);
    notifyListeners();
    
    // Show loading
    _isLoading = true;
    notifyListeners();
    
    try {
      // Get AI response with context
      final response = await _aiService.getResponse(
        userMessage,
        scheduleProvider.activitiesForSelectedDate,
        scheduleProvider.completionRate,
      );
      
      _messages.add(ChatMessage.ai(response, type: MessageType.text));
    } catch (e) {
      _messages.add(ChatMessage.ai(
        'Maaf, terjadi kesalahan. Silakan coba lagi.\n\nError: ${e.toString()}',
        type: MessageType.text,
      ));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void clearMessages() {
    _messages.clear();
    _addWelcomeMessage();
    notifyListeners();
  }
}
