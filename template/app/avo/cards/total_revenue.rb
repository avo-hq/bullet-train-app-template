class Avo::Cards::TotalRevenue < Avo::Dashboards::MetricCard
  self.id = "total_revenue"
  self.label = "Total revenue"
  self.prefix = "$"

  def query
    case arguments[:period]
    when :last_12_months
      result last_12_months
    when :last_month
      result last_month
    when :this_month
      result this_month
    else
      result total_revenue
    end
  end

  def total_revenue
    revenue_in_cents = ::Pay::Charge.sum(:amount)
    refunds_in_cents = ::Pay::Charge.sum(:amount_refunded)
    (revenue_in_cents - refunds_in_cents) / 100.0
  end

  def last_12_months
    revenue_for_range 12.months.ago..Time.current
  end

  def last_month
    month = Time.current.prev_month
    revenue_for_range month.beginning_of_month..month.end_of_month
  end

  def this_month
    month = Time.current
    revenue_for_range month.beginning_of_month..month.end_of_month
  end

  def revenue_for_range(range)
    revenue_in_cents = ::Pay::Charge.where(created_at: range).sum(:amount)
    refunds_in_cents = ::Pay::Charge.where(created_at: range).sum(:amount_refunded)
    (revenue_in_cents - refunds_in_cents) / 100.0
  end
end
