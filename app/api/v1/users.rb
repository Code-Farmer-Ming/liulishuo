# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
# encoding: utf-8
module V1
  class Users < Application
    resource :users do

      get do
        present User.all, with: Entities::User
      end
    end

    
  end
end
