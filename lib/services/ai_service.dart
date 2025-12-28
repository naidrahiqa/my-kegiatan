import 'package:intl/intl.dart';
import '../models/activity.dart';

class AIService {
  // Simulasi AI response - Bisa diganti dengan Google Generative AI
  // Untuk menggunakan Gemini AI, uncomment kode di bawah dan tambahkan API key
  
  /*
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'YOUR_API_KEY_HERE', // Ganti dengan API key Anda
  );
  */

  Future<String> getResponse(
    String userMessage,
    List<Activity> todayActivities,
    double completionRate,
  ) async {
    // Simulasi delay untuk membuat lebih realistis
    await Future.delayed(const Duration(seconds: 1));

    // Context building
    final context = _buildContext(todayActivities, completionRate);
    
    // Simple rule-based responses for demonstration
    // Ganti dengan API call ke Gemini untuk response yang lebih cerdas
    return _getSimulatedResponse(userMessage.toLowerCase(), context);
  }

  String _buildContext(List<Activity> activities, double completionRate) {
    final totalActivities = activities.length;
    final completed = activities.where((a) => a.isCompleted).length;
    final totalMinutes = activities.fold(0, (sum, a) => sum + a.durationMinutes);
    
    return '''
Konteks Jadwal Hari Ini:
- Total aktivitas: $totalActivities
- Selesai: $completed
- Tingkat penyelesaian: ${completionRate.toStringAsFixed(1)}%
- Total waktu terjadwal: ${totalMinutes} menit
''';
  }

  String _getSimulatedResponse(String message, String context) {
    // Analisis jadwal
    if (message.contains('analisis') || message.contains('bagaimana')) {
      return _analyzeSchedule(context);
    }
    
    // Saran produktivitas
    if (message.contains('saran') || message.contains('tips') || 
        message.contains('rekomendasi')) {
      return _getProductivityTips();
    }
    
    // Manajemen waktu
    if (message.contains('waktu') || message.contains('kapan')) {
      return _getTimeManagementAdvice();
    }
    
    // Motivasi
    if (message.contains('motivasi') || message.contains('semangat')) {
      return _getMotivation();
    }
    
    // Default response
    return _getDefaultResponse(context);
  }

  String _analyzeSchedule(String context) {
    return '''
Oke, gw cek jadwal kamu ya! 📊

$context

Nih penilaian gw:
• Kalau completion rate kamu di atas 80%, mantap banget! Kamu produktif hari ini 🔥
• Kalau masih di bawah 50%, mungkin agak kebanyakan target. Coba kurangi dikit atau kasih waktu lebih banyak per task
• Jangan lupa istirahat 10-15 menit tiap 90 menit ya biar otak gak lemot
• Pagi itu golden hours - manfaatin buat ngerjain yang paling penting pas energi masih fresh!

Tips dari gw:
✓ Coba teknik Pomodoro - 25 menit fokus, 5 menit istirahat
✓ Jangan multitasking berlebihan, fokus satu-satu aja
✓ Block waktu khusus buat deep work - matiin notif biar gak terganggu
''';
  }

  String _getProductivityTips() {
    final tips = [
      '''
Nih gw kasih tips produktivitas yang gw suka pake! 💡

1. **Eat The Frog** 🐸
   Pagi-pagi langsung babat tugas yang paling berat. Setelah itu sisanya berasa lebih ringan!

2. **Time Blocking** ⏰
   Set jam-jam tertentu buat aktivitas spesifik. Misal jam 9-11 khusus buat ngoding, jam 2-3 buat meeting. Lebih terstruktur deh!

3. **2-Minute Rule** ⚡
   Kalau bisa kelar dalam 2 menit, langsung eksekusi aja. Jangan ditunda-tunda!

4. **Kenali Ritme Kamu** 🎯
   Ada yang produktif pagi, ada yang malem. Pelajari pola kamu sendiri dan manfaatin!

5. **Single Tasking** 🎪
   Fokus satu task sampai beres. Multitasking cuma bikin kamu capek dan hasilnya setengah-setengah.

Cobain deh satu-satu, pasti ada yang cocok! 😉
''',
      '''
Gw share strategi manajemen waktu favorit gw! 🎯

**Matriks Eisenhower** (super helpful ini!)
  - Urgent & Penting → Garap sekarang juga!
  - Penting tapi gak urgent → Jadwalin kapan mau dikerjain
  - Urgent tapi gak penting → Kalau bisa delegate ke orang lain  
  - Gak urgent & gak penting → Buang aja, time waster!

**Batching** 📦
  Kelompokin task yang sejenis. Misal bales email sekaligus banyak dalam satu sesi, daripada satu-satu sepanjang hari

**Buffer Time** ⏱️
  Jangan jadwalin 100% hari kamu. Kasih jeda 15-20% buat hal-hal tak terduga. Pasti ada aja yang muncul!

**Weekly Review** 📝
  Tiap akhir minggu, evaluasi apa yang udah lu capai dan rencana in minggu depan. Game changer banget ini!

Try it out! 🚀
''',
    ];
    
    return tips[DateTime.now().second % tips.length];
  }

  String _getTimeManagementAdvice() {
    return '''
Gw jelasin waktu-waktu terbaik buat produktif ya! ⏰

**Pagi (06:00 - 12:00)** ☀️
Best time buat: Ngerjain project berat, mikir analitis, problem solving
Soalnya energi mental masih peak! Manfaatin banget waktu ini.

**Siang (12:00 - 15:00)** 🌤️
Good for: Meeting, diskusi, urusin admin
Abis makan siang biasanya agak drop energinya. Jadi jangan dipaksain buat hal berat.

**Sore (15:00 - 18:00)** 🌅
Cocok buat: Brainstorming, kerjaan kreatif, planning
Energi naik lagi di sore, kreativitas juga meningkat!

**Malam (18:00 - 22:00)** 🌙
Ideal untuk: Review, belajar hal baru, prep esok hari
Waktu yang tenang buat refleksi dan persiapan.

💡 Tapi inget ya, tiap orang beda-beda. Ada yang morning person, ada yang night owl. Kenali ritme kamu sendiri dan adjust sesuai kebutuhan!
''';
  }

  String _getMotivation() {
    final motivations = [
      '''
Butuh semangat? Nih gw kasih! 💪

"Kesuksesan itu bukan instant. Tapi hasil dari hal-hal kecil yang dikerjain konsisten."

Inget ya:
• Every small step counts! Jangan remehkan progress kecil
• Konsistensi > Intensitas. Better slow and steady daripada burnout
• Progress lebih penting dari perfection. Done is better than perfect!

Lu bisa kok! Let's go! 🚀
''',
      '''
Yuk semangat lagi! 🌟

"Disiplin itu yang ngebridge antara goal sama achievement."

Tips biar tetep semangat:
• Celebrate small wins! Setiap target tercapai itu pencapaian
• Fokus ke prosesnya, bukan cuma hasilnya
• Rest is productive too - jangan lupa istirahat
• Lu lagi bangun habit yang bakal shape masa depan kamu

Keep pushing! You got this! 💪
''',
      '''
Hei, jangan menyerah! 🔥

"Hari ini mungkin berat, tapi besok lu akan lebih kuat."

Real talk:
• Susah itu wajar, semua orang ngalamin
• Yang ngebedain cuma siapa yang tetep jalan meski susah
• Setiap hari konsisten = compound effect yang luar biasa
• Trust the process!

Lu amazing, terus aja! 🚀
''',
    ];
    
    return motivations[DateTime.now().second % motivations.length];
  }

  String _getDefaultResponse(String context) {
    final responses = [
      '''
Halo! Ada yang bisa gw bantu? 😊

$context

Gw bisa bantuin kamu dengan:
• Ngecek dan nganalisis jadwal kamu
• Kasih tips produktivitas
• Saranin waktu terbaik buat aktivitas tertentu
• Kasih motivasi kalau lagi down

Tanya aja santai, misalnya:
- "Gimana jadwal gw hari ini?"
- "Kasih tips dong biar produktif"
- "Kapan waktu terbaik buat belajar?"
- "Gw butuh motivasi nih"

Shoot! 🎯
''',
      '''
Hai! Mau konsultasi apa nih? 😎

$context

Lu bisa tanya gw tentang:
• Analisis efektivitas jadwal lu
• Tips dan trik produktivitas
• Waktu optimal buat ngerjain sesuatu
• Motivasi biar tetep semangat

Contoh pertanyaan:
- "Analisis jadwal gw dong"
- "Ada saran biar lebih produktif?"
- "Jam berapa bagusnya olahraga?"
- "Gw lagi males nih, kasih motivasi"

Apapun, gw siap bantuin! 💪
''',
    ];
    
    return responses[DateTime.now().second % responses.length];
  }

  // Uncomment fungsi ini jika menggunakan Google Generative AI
  /*
  Future<String> _getGeminiResponse(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Maaf, tidak dapat menghasilkan respons.';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
  */
}
