require 'active_support'

import 'java.lang.reflect.Modifier'

module JRSplenda
  module FieldHelper
    def wrap_java_fields(object)
      klass = (object.is_a?(Class)) ? object : object.class
      klass.java_class.declared_fields.each do |field|
        define_getter(object, field)
        next if field.modifiers & Modifier::FINAL != 0        
        define_setter(object, field)
      end
    end
    
    private
    def define_getter(object, field)
      return if !(object.is_a?(Class) && is_static?(field)) &&
                !(!object.is_a?(Class) && is_instance?(field))
      method_name = field.name.underscore
      object.singleton_class.send(:define_method, method_name) do
        field.accessible = true
        if object.is_a?(Class) && is_static?(field)
          val = Java.java.to_ruby(field.static_value)
        elsif !object.is_a?(Class) && is_instance?(field)
          val = Java.java_to_ruby(field.value(object.java_object))
        end
        field.accessible = false
        val
      end  
      create_java_formatted_alias :on => object, :for => method_name, :called => field.name
    end    
    
    def define_setter(object, field)
      return if !(object.is_a?(Class) && is_static_non_final?(field)) &&
                !(!object.is_a?(Class) && is_instance_non_final?(field))
      method_name = "#{field.name.underscore}="      
      object.singleton_class.send(:define_method, method_name) do |val|
        field.accessible = true
        if object.is_a?(Class) && is_static_non_final?(field)
          field.set_static_value(Java.ruby_to_java(val.java_object))
        elsif !object.is_a?(Class) && is_instance_non_final?(field)
          field.set_value(java_object, Java.ruby_to_java(val.java_object))
        end
        field.accessible = false
      end
      create_java_formatted_alias :on => object, :for => method_name, :called => "#{field.name}="
    end
  end
end

[String, NilClass].each do |klass|
  klass.class_eval do 
    unless method_defined? :java_object
      define_method(:java_object) do
        Java.ruby_to_java(self)
      end
    end
  end
end

class Object
  def singleton_class
    class << self; self; end
  end
end