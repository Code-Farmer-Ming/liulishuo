class History < ActiveRecord::Base
  belongs_to :user, counter_cache: 'history_count'
end
