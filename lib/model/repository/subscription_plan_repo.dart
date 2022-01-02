import 'package:test_task/model/subscription_plan.dart';

abstract class SubscriptionPlanRepository {
  Future<List<SubscriptionPlan>> fetchSubscriptionPlans();
}
