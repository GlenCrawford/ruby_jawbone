module RubyJawbone
  module FileReaders
    class Base
      attr_reader :file

      def initialize(file)
        @file = file
      end
    end
  end
end
