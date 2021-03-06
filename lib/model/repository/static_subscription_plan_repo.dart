import 'package:test_task/model/subscription_plan.dart';
import 'subscription_plan_repo.dart';

class StaticSubscriptionPlanRepository implements SubscriptionPlanRepository {
  @override
  Future<List<SubscriptionPlan>> fetchSubscriptionPlans() async {
    return [
      SubscriptionPlan("yearly", 19.99, 12, 29.99),
      SubscriptionPlan("monthly", 4.99, 1),
    ];
  }
}
