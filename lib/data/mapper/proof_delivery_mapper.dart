import 'package:smart_courier_assistant/data/model/proof_delivery_model.dart';
import 'package:smart_courier_assistant/domain/entity/proof_delivery_entity.dart';

class ProofDeliveryMapper {
  static ProofDeliveryModel? fromEntity(
    ProofDeliveryEntity? proofDeliveryEntity,
  ) {
    return ProofDeliveryModel(
      courierComment: proofDeliveryEntity?.courierComment ?? '',
      orderPhotos: proofDeliveryEntity?.orderPhotos ?? [],
      confirmedAt: proofDeliveryEntity?.confirmedAt ?? DateTime.now(),
    );
  }
}
