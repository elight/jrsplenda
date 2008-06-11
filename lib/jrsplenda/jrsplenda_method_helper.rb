require 'active_support'

import 'java.lang.reflect.Modifier'

module JRSplenda
  module MethodHelper
    def wrap_java_methods(object)
      if object.is_a?(Class)
        klass = object
        message = :java_class
        method_type = :declared_class_methods
      else 
        klass = object.class
        message = :java_object
        method_type = :declared_instance_methods
      end
      uniq_method_names = klass.java_class.send(method_type).collect(&:name)
      uniq_method_names.each do |method_name|
        method = klass.java_class.declared_method_smart(method_name) 
        next if method.modifiers & (Modifier::PUBLIC | Modifier::FINAL) != 0
        ruby_method_name = "#{method.name.underscore}"
        object.singleton_class.send :define_method, ruby_method_name do |*args|
          method.accessible = true
          result = nil
          if method.modifiers & Modifier::STATIC != 0
            result = method.invoke_static(*args)
          else
            result = method.invoke(send(message), *args)
          end
          method.accessible = false
          result
        end
        object.singleton_class.send(:alias_method, method_name, ruby_method_name)
      end
    end
  end
end