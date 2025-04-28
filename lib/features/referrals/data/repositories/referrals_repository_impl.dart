import 'package:moi_market/features/notification/data/api/notification_api.dart';
import 'package:moi_market/features/notification/domain/repositories/notification_repository.dart';
import 'package:moi_market/features/referrals/data/api/referrals_api.dart';
import 'package:moi_market/features/referrals/data/models/referral.dart';
import 'package:moi_market/features/referrals/data/models/referrals_common_response.dart';
import 'package:moi_market/features/referrals/domain/repositories/referrals_repository.dart';

class ReferralsRepositoryImpl implements ReferralsRepository {
  final ReferralsApi api;

  ReferralsRepositoryImpl({required this.api});

  @override
  Future<ReferralsCommonResponse?> getReferrals() {
    return api.getReferrals();
  }

  @override
  Future<Referral?> createReferral({required String name, required String phone}) {
    return api.createReferral(phone: phone, name: name);
  }
}