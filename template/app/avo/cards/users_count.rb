class Avo::Cards::UsersCount < Avo::Dashboards::MetricCard
  self.id = "users_count"
  self.label = "Users count"
  self.description = "Total number of users registered"

  def query
    result ::User.all.count
  end
end
