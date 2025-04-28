import 'package:moi_market/features/referrals/data/models/referral.dart';
import 'package:moi_market/features/referrals/data/models/referrals_common_response.dart';

abstract class ReferralsRepository {
  Future<ReferralsCommonResponse?> getReferrals();

  Future<Referral?> createReferral({required String name, required String phone});
}