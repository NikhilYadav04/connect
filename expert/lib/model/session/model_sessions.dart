//* Session model representing a recent session entry
enum SessionType { video, chat, phone }

class Session {
  final String participant;
  final SessionType type;
  final int durationMinutes;
  final DateTime date;
  final double amount;

  Session({
    required this.participant,
    required this.type,
    required this.durationMinutes,
    required this.date,
    required this.amount,
  });
}

//* Sample data: 50 sessions
final List<Session> recentSessions = List.generate(50, (i) {
  const participants = ['John D.', 'Sarah M.', 'Mike R.', 'Emma L.', 'David K.'];
  final participant = participants[i % participants.length];
  final type = SessionType.values[i % SessionType.values.length];
  final duration = [45, 30, 60, 40, 25][i % 5];
  final date = DateTime(2024, 1, 15).subtract(Duration(days: i));
  //* sample rate mapping: video=2.5, chat=1.5, phone=3.0 per min
  final ratePerMin = type == SessionType.video
      ? 2.5
      : (type == SessionType.chat ? 1.5 : 3.0);
  final amount = ratePerMin * duration;

  return Session(
    participant: participant,
    type: type,
    durationMinutes: duration,
    date: date,
    amount: amount,
  );
});
