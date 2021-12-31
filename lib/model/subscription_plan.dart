class SubscriptionPlan {
  String name;
  double rate;
  double? oldRate;
  int periodInMonths;

  SubscriptionPlan(this.name, this.rate, this.periodInMonths, [this.oldRate]);

  double percentSavings() {
    if (oldRate == null) return 0;
    return (oldRate! - rate) * 100 / oldRate!;
  }

  double monthlyRate() {
    return rate / periodInMonths;
  }
}
