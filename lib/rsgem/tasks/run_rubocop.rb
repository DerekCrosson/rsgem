# frozen_string_literal: true

module RSGem
  module Tasks
    class RunRubocop < Base
      OUTPUT = OutputStruct.new(name: 'Run rubocop')

      def perform
        system("cd #{context.folder_path} && bundle exec rubocop -a", out: '/dev/null')
        raise RSGem::Errors::Base if $? != 0
      end
    end
  end
end
