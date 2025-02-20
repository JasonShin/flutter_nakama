import 'package:faker/faker.dart';
import 'package:nakama/api.dart' as api;
import 'package:nakama/nakama.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../config.dart';

void main() {
  group('[gRPC] Test Leaderboard', () {
    late final NakamaBaseClient client;
    late final Session session;

    setUpAll(() async {
      client = getNakamaClient(
        host: host,
        ssl: false,
        serverKey: serverKey,
      );

      session = await client.authenticateDevice(deviceId: faker.guid.guid());
    });

    test('list leaderboard records', () async {
      final result = await client.listLeaderboardRecords(
        session: session,
        leaderboardName: 'test',
      );

      expect(result, isA<api.LeaderboardRecordList>());
    });

    test('write leaderboard record', () async {
      final result = await client.writeLeaderboardRecord(
          session: session, leaderboardId: 'test', score: 10);

      expect(result, isA<api.LeaderboardRecord>());
      expect(result.score.toInt(), equals(10));
    });
  });
}
