module V1
  class Application < Grape::API
    def self.inherited(child)
      super
      child.format :json
      child.prefix "api"
      child.version 'v1', :using => :path
      child.helpers do

        def strong_params
          ActionController::Parameters.new(params)
        end
      end
    end
  end

end
