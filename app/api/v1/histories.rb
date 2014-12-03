# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
# encoding: utf-8
module V1
  class Histories < Application
    resource :histories do

      get do
        present History.all.order('created_at desc').limit(10), with: Entities::History
      end
    end


  end
end
