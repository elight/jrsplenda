module JRSplenda
  module AllHelpers
    include FieldHelper
    include MethodHelper
    include MockHelper
  
    def wrap_java_object(obj)
      wrap_java_fields(obj)
      wrap_java_methods(obj)
    end
  end
end