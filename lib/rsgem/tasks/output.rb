# frozen_string_literal: true

module RSGem
  module Tasks
    #
    # Structure to bundle all messages from a task
    #
    OutputStruct = Struct.new(:name, :success, :warning, :error, keyword_init: true)

    module Output
      def with_output
        begin
          yield
          puts "\t#{Colors.colorize("[OK]", :green)} #{name}"
          puts "\t#{warning}" if warning
          puts "\t#{success}" if success
        rescue RSGem::Errors::Base => e
          puts "\t#{e.message}"
          puts "\t#{error}" if error
          raise e
        end
      end

      private

      def deduce_output(value)
        case value
        when String
          value
        when Symbol
          self.send(value)
        when Proc
          value.call
        else
          nil
        end
      end

      def error
        deduce_output(self.class::OUTPUT.error)
      end

      def name
        deduce_output(self.class::OUTPUT.name || self.class.name)
      end

      def success
        deduce_output(self.class::OUTPUT.success)
      end

      def warning
        deduce_output(self.class::OUTPUT.warning)
      end
    end
  end
end
