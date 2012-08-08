module Laundry
  module PaymentsGateway

    class ResponseModel

      attr_accessor :response
      attr_accessor :merchant
      def initialize(response, merchant)
        self.response = response
        self.merchant = merchant
      end
      
      # Override please.
      def record
        response.try(:to_hash) || {}
      end
      
      def to_hash
        record
      end
      
      def method_missing(id, *args)
        return record[id.to_sym] if record.try(:has_key?, id.to_sym)
        super
      end
        
    end

  end
end