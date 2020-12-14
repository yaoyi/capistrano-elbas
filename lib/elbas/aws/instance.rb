module Elbas
  module AWS
    class Instance < Base
      STATE_RUNNING = 16.freeze

      attr_reader :aws_counterpart, :id, :state

      def initialize(id, private_dns, state)
        @id = id
        @private_dns = private_dns
        @state = state
        @aws_counterpart = aws_namespace::Instance.new id, client: aws_client
      end

      def hostname
        @private_dns
      end

      def running?
        state == STATE_RUNNING
      end

      private
        def aws_namespace
          ::Aws::EC2
        end
    end
  end
end
