class Avo::Dashboards::Overview < Avo::Dashboards::BaseDashboard
  self.id = "overview"
  self.name = "Overview"
  self.grid_cols = 4

  def cards
    divider label: "Revenue"
    card Avo::Cards::TotalRevenue,
      arguments: {
        period: :this_month
      },
      label: "This month"
    card Avo::Cards::TotalRevenue,
      arguments: {
        period: :last_month
      },
      label: "Last month"
    card Avo::Cards::TotalRevenue,
      arguments: {
        period: :last_12_months
      },
      label: "Last 12 months"
    card Avo::Cards::TotalRevenue

    divider

    card Avo::Cards::UsersCount
    card Avo::Cards::ActiveSubscriptions
  end
end
