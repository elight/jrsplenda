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
    
    def splenda_mock_attr(arg, options = {})
      default_field_name = stringify_class(arg).split('.').last.underscore
      attr_name = "@" + options.fetch(:store_in, default_field_name).to_s
      should_preserve_attr = options[:preserve_existing_attr]
      current_attr_val = instance_variable_get(attr_name)
      unless current_attr_val && should_preserve_attr
        instance_variable_set(attr_name, splenda_mock(arg))
      end
    end
    
    def splenda_partial_mock(arg)
      puts "??? #{arg} #{arg.inspect}"
      internal_mock(arg) do |class_name|
        partial_mock(class_name)
      end
    end
   
#   def splenda_partial_mock_attr(arg, options = {})
        
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
        puts "^^^ #{arg} #{arg.inspect}"
        import arg
        begin
          arg = arg.split('.').last
          mock_class = Class.new(Module.const_get(arg))
          mock_class.class_eval do
            alias :mocha_expects :expects
            def expects(method)
              (class << self; self; end).class_eval{ remove_method method }
              mocha_expects(method)
            end
          end 
          mock = mock_class.new
          wrap_java_fields mock
          wrap_java_methods mock
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
          puts "@@@ #{name} #{name.inspect}"
        else
          name = klass.to_s
        end
        name
      end
  end
end  

