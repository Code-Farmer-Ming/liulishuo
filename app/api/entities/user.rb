module Entities
  class User< Grape::Entity
    expose :id,:name,:history_count
  end
end