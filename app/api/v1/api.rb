# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
module V1
  class API <Grape::API
    mount V1::Histories
    mount V1::Users
  end
end
