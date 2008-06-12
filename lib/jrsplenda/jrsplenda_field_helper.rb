require 'active_support'

import 'java.lang.reflect.Modifier'

module JRSplenda
  module FieldHelper
    def wrap_java_fields(object)
      if object.is_a?(Class)
        klass = object
        message = :java_class
      else 
        klass = object.class
        message = :java_object
      end
      klass.java_class.declared_fields.each do |field|
        next if field.modifiers & (Modifier::PUBLIC | Modifier::FINAL) != 0
        method_name = "#{field.name.underscore}"
        if object.is_a?(Class) && (field.modifiers & Modifier::STATIC != 0)
          object.singleton_class.send(:define_method, method_name) do
            field.accessible = true
            val = field.static_value
            field.accessible = false
            val
          end
          object.singleton_class.send(:alias_method, field.name, method_name)
          object.singleton_class.send(:define_method, method_name + "=") do |val|
            field.accessible = true
            field.set_static_value(val.java_object)
            field.accessible = false
          end
          object.singleton_class.send(:alias_method, field.name + "=", method_name + "=")
        elsif !object.is_a?(Class) && (field.modifiers & Modifier::STATIC == 0)
          object.singleton_class.send(:define_method, method_name + "=") do |val|
            field.accessible = true
            field.set_value(send(message), val.java_object)
            field.accessible = false
          end
          object.singleton_class.send(:alias_method, field.name + "=", method_name + "=")
        end
      end
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