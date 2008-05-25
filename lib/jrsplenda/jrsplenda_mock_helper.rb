module JRSplenda
  module MockHelper
    def splenda_mock(arg)
      arg = arg.java_class if arg.respond_to? :java_class
      arg = arg.to_s
      # Consider whether we really want to import; may want to avoid overlap.  Import by default?
      import arg
      vendor_mock Module.const_get(arg.split('.').last)
    end
    
    private
      def vendor_mock(arg)
        # default is Mocha but monkey-patch this to support other mock types
        mock arg.to_s
      end

  end

end