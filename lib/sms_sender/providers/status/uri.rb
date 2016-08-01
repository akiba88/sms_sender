module SmsSender
  module Providers
    module Status
  	  class Uri
  	  	def get(id_transaction)
  		    HTTP.get(request_url, params: request_params(id_transaction))
    		end

      protected

        def request_url
          @request_path ||= options['status_request']['url']
        end

        def request_params(id_transaction)
          return @request_params if defined?(@request_params)

          hash = options['status_request']['static']
          hash[options['status_request']['id_key']] = id_transaction

          @request_params = hash
        end
  	  end
  	end
  end
end
