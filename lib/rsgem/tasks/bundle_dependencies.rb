# frozen_string_literal: true

module RSGem
  module Tasks
    class BundleDependencies < Base
      OUTPUT = OutputStruct.new(name: 'Bundle dependencies')

      def perform
        system('cd #{context.folder_path} && bundle', out: '/dev/null')
        raise RSGem::Errors::Base if $? != 0
      end
    end
  end
end
