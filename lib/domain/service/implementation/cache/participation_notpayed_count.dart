import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sola/domain/entity/update_cache/participation_count.dart';
import 'package:sola/domain/service/interface/cache/i_participation_notpayed_count.dart';

class ParticipationCountCache implements IParticipationCountCache {
  final DataSource<ParticipationCount> dataSource;
  ParticipationCountCache({required this.dataSource});

  @override
  Future<ParticipationCount?> getParticipationNotPayedCount() async{
    List<ParticipationCount> updates = await dataSource.getAll();
    return updates.isNotEmpty ? updates[updates.length-1] : null;
  }

  @override
  Future<bool> isUpdateNeeded() async {
    final lastUpdate = await getParticipationNotPayedCount();
    final today = DateTime.now().toIso8601String().split('T')[0];
    return lastUpdate?.dateTime.toIso8601String().split('T')[0] != today;
  }

  @override
  Future<void> save() async{
    int count=  await getCount();
    if (count==0) {
      await dataSource.insert(ParticipationCount(participationCount: 1, dateTime: DateTime.now()));
    }else{
      await dataSource.insert(ParticipationCount(participationCount:count+ 1, dateTime: DateTime.now()));
    }
  }

  @override
  Future<void> reInitCount() async{
    dataSource.insert(ParticipationCount(participationCount: 0, dateTime: DateTime.now()));
  }
  
  @override
  Future<int> getCount() async{
    ParticipationCount? p = await getParticipationNotPayedCount();
    if(p ==null) return 0;
    return p.participationCount;
  }
  
  @override
  Future<void> participationRegistered() async{
    await dataSource.insert(ParticipationCount(participationCount: await getCount()-1, dateTime: DateTime.now()));
  }
  
}