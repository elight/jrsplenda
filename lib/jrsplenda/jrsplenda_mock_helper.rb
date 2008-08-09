require 'active_support'

module JRSplenda  
  module MockHelper
    include JRSplenda::MethodHelper
    include JRSplenda::FieldHelper
    
    def splenda_mock(arg)
      internal_mock(arg) do |class_name|
        vendor_mock(class_name)
      end
    end
    
    def splenda_partial_mock(arg)
      internal_mock(arg) do |class_name|
        partial_mock(class_name)
      end
    end
        
    private
      def internal_mock(class_name, &block)
        if class_name.instance_of? Class
          class_name = stringify_class(class_name)
        end
        mock_obj = yield(class_name)
        mock_obj
      end
    
      # default is Mocha but monkey-patch this to support other mock types
      def vendor_mock(arg)
        import arg
        begin
          arg = arg.split('.').last
          mock(Module.const_get(arg))
        rescue Exception => e
          puts "Exception: #{e}"
          puts e.backtrace
        end
      end
      
      def partial_mock(arg)
        @@partial_counter ||= 0
        import arg
        begin
          arg = arg.split('.').last
          mock_class = Class.new(Module.const_get(arg))
          Module.const_set("#{arg}PartialMock#{@@partial_counter += 1}", mock_class)
          mock = mock_class.new
          wrap_java_fields mock
          wrap_java_methods mock
          mock_class.class_eval do
            alias :mocha_expects :expects
            def expects(method)
              # (class << self; self; end).class_eval { undef_method method }
              # self.class.class_eval { undef_method method }
              mocha_expects(method)
            end
          end 
        rescue Exception => e
          puts "Exception: #{e}"
          puts e.backtrace
        end
        mock
      end      
            
      def stringify_class(klass)
        name = nil
        if klass.respond_to? :java_class
          name = klass.java_class.name
        else
          name = klass.to_s
        end
        name
      end
  end
end  

