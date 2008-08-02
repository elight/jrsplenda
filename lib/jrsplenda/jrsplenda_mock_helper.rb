require 'active_support'

module JRSplenda  
  module MockHelper
    include JRSplenda::MethodHelper
    include JRSplenda::FieldHelper
    
    def splenda_mock(arg)
      if arg.instance_of? Class
        if arg.respond_to? :java_class
          arg = arg.java_class.to_s
        else
          arg = arg.to_s
        end
      else
        # Consider whether we really want to import; may want to avoid overlap.  Import by default?
        import arg
      end
      mock_obj = vendor_mock arg
      mock_obj
    end
    
    def splenda_mock_attr(arg, options = {})
      default_field_name = java_class_as_string(arg).split('.').last.underscore
      attr_name = "@" + options.fetch(:store_in, default_field_name).to_s
      should_preserve_attr = options[:preserve_existing_attr]
      current_attr_val = instance_variable_get(attr_name)
      unless current_attr_val && should_preserve_attr
        instance_variable_set(attr_name, splenda_mock(arg))
      end
    end
    
    def splenda_partial_mock(arg)
      if arg.instance_of? Class
        if arg.respond_to? :java_class
          arg = arg.java_class.to_s
        else
          arg = arg.to_s
        end
      else
        # Consider whether we really want to import; may want to avoid overlap.  Import by default?
        import arg
      end
      mock_obj = partial_mock arg
      mock_obj
    end
        
    private
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
        import arg
        begin
          arg = arg.split('.').last
          mock = (Module.const_get(arg)).new
          wrap_java_fields mock
          wrap_java_methods mock          
          # add expectation and stubbing behavior here
        rescue Exception => e
          puts "Exception: #{e}"
          puts e.backtrace
        end
        mock
      end      
      
      def java_class_as_string(arg)
        arg = arg.java_class if arg.respond_to? :java_class
        arg.to_s
      end
  end
end  

