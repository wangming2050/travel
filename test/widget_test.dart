import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_group1/taiyuan/ty_taiyuan_app.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

/// 太原城市 App 测试
void main() {
  setUp(() {
    VideoPlayerPlatform.instance = _FakeVideoPlayerPlatform();
  });

  testWidgets('starts on Taiyuan page and opens assistant', (tester) async {
    await tester.pumpWidget(const TaiyuanApp());
    await tester.pump();

    expect(find.text('타이위안'), findsOneWidget);
    expect(find.text('소개'), findsOneWidget);
    expect(find.text('명소'), findsOneWidget);
    expect(find.text('음식'), findsOneWidget);
    expect(find.text('코스'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.tap(find.byKey(const ValueKey('taiyuanCityLogoButton')));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('여행 도우미'), findsOneWidget);
    expect(find.text('🍜 음식 추천'), findsOneWidget);

    await tester.tapAt(const Offset(400, 80));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('여행 도우미'), findsNothing);
  });
}

class _FakeVideoPlayerPlatform extends VideoPlayerPlatform {
  int _nextPlayerId = 0;
  final _streams = <int, StreamController<VideoEvent>>{};

  @override
  Future<void> init() async {}

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
    final playerId = _nextPlayerId++;
    final stream = StreamController<VideoEvent>();
    _streams[playerId] = stream;
    stream.add(
      VideoEvent(
        eventType: VideoEventType.initialized,
        size: const Size(100, 100),
        duration: const Duration(seconds: 1),
      ),
    );
    return playerId;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int playerId) {
    return _streams[playerId]!.stream;
  }

  @override
  Widget buildView(int playerId) {
    return const SizedBox.expand();
  }

  @override
  Future<void> dispose(int playerId) async {
    await _streams.remove(playerId)?.close();
  }

  @override
  Future<void> play(int playerId) async {}

  @override
  Future<void> pause(int playerId) async {}

  @override
  Future<void> setLooping(int playerId, bool looping) async {}

  @override
  Future<void> setVolume(int playerId, double volume) async {}

  @override
  Future<void> setPlaybackSpeed(int playerId, double speed) async {}

  @override
  Future<Duration> getPosition(int playerId) async {
    return Duration.zero;
  }
}
