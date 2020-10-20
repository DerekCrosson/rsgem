# frozen_string_literal: true

module RSGem
  module Tasks
    class CreateGem < Base
      OUTPUT = OutputStruct.new(
        name: 'Create gem',
        success: :success_message,
        error: "Failed to run `bundle gem'. "\
          "Check bundler is installed in your system or install it with `gem install bundler'.`"
      )

      def perform
        system(shell_command, out: '/dev/null')

        if $? != 0
          raise RSGem::Errors::Base
        end
      end

      private

      def bundler_options
        context.bundler_options
      end

      def success_message
        "Gem created with bundler options: #{bundler_options}" if bundler_options
      end

      def shell_command
        [
          "bundle gem #{context.gem_name} --test=rspec --coc --mit",
          bundler_options
        ].compact.join(' ')
      end
    end
  end
end
