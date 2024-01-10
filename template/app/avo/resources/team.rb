class Avo::Resources::Team < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], name_cont: params[:q], slug_cont: params[:q], m: "or").result(distinct: false) },
    item: -> {
      {
        title: record.name
      }
    }
  }

  def fields
    field :id, as: :id
    field :email, as: :text
    field :first_name, as: :text
    field :last_name, as: :text
    field :time_zone, as: :select, options: -> { view_context.time_zone_options_for_select(Avo::Current.user.time_zone, nil, ActiveSupport::TimeZone) }
    field :current_team, as: :belongs_to

    field :teams, as: :has_many, through: :teams
    field :memberships, as: :has_many
  end
end
