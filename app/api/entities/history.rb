module Entities
  class History< Grape::Entity
    expose :id,:desc,:created_at
    expose :user_name do |model|
      model.user.name
    end

  end
end