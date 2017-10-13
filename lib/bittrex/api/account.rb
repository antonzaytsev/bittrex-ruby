# frozen_string_literal: true

# https://bittrex.com/Home/Api
module Bittrex
  module Api
    module Account
      include Clientable

      ACCOUNT_APIS = [
        [:getbalances],
        [:getorderhistory, %i(market)],
        [:getwithdrawalhistory],
        [:getdeposithistory],
        [:getbalance, %i(currency)],
        [:getdepositaddress, %i(currency)],
        [:getorder, %i(uuid)],
        [:withdraw, %i(currency quantity address paymentid)]
      ]


      ACCOUNT_APIS.each do |key, params|
        params    ||= []
        arguments = params.map {|i| "#{i} = nil"}.join(',')

        class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{key}(#{arguments})
            client.get("account/#{key}"#{',' unless params.empty?}#{params.map {|i| "#{i}: #{i}"}.join(", ")})
        end
        module_function :#{key}
        CODE
      end


      # def getbalances
      #   client.get('account/getbalances')
      # end

      # def getorderhistory(market)
      #   client.get('account/getorderhistory', market: market)
      # end

      # def getwithdrawalhistory
      #   client.get('account/getwithdrawalhistory')
      # end
    end
  end
end
