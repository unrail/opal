module Opal
  module Sprockets

    class PathReader
      def initialize(env, context)
        @env ||= env
        @context ||= context
      end

      def read path
        if path.end_with? '.js'
          context.depend_on_asset(path)
          env[path].to_s
        else
          context.depend_on(path)
          File.read(env.resolve(path))
        end
      rescue ::Sprockets::FileNotFound
        nil
      end

      attr_reader :env, :context
    end

  end
end
