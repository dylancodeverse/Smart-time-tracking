import 'package:sola/data/interface/bus_state_custom/bus_state_custom.dart';
import 'package:sola/domain/service/interface/cache/i_last_update_repo.dart';
import 'package:sola/domain/service/interface/denormalization/i_denormalize_state.dart';

class DenormalizeState implements IDenormalizeState {

// depend de la partie data layer pour que les logiques metiers sont les seules choses ici xd
  BusStateCustom busStateCustom;

  LastUpdateRepository lastUpdateRepository;


  DenormalizeState({required this.busStateCustom, required this.lastUpdateRepository});

  @override
  Future<void> verification()  async{
    bool needsUpdate = await lastUpdateRepository.isUpdateNeeded();
    if (needsUpdate) {
      print("🔄 Mise à jour nécessaire !");
      await busStateCustom.update();
      await lastUpdateRepository.save(DateTime.now());
    } else {
      print("✅ Déjà mis à jour aujourd’hui.");
    }
  }
}