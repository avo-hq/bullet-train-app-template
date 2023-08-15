class Avo::Cards::ActiveSubscriptions < Avo::Dashboards::MetricCard
  self.id = "active_subscriptions"
  self.label = "Active subscriptions"
  self.description = "Total number of active subscriptions"

  def query
    result ::Pay::Subscription.active.count
  end
end
