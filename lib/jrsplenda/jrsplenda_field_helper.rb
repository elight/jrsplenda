require 'active_support'

import 'java.lang.reflect.Modifier'

module JRSplenda
  module FieldHelper
    def wrap_java_fields(object)
      object.class.java_class.declared_fields.each do |field|
        next if field.modifiers & (Modifier::PUBLIC | Modifier::FINAL) != 0
        method_name = "#{field.name.underscore}="
        object.singleton_class.send :define_method, method_name do |val|
          field.accessible = true
          field.set_value(java_object, val.java_object)
          field.accessible = false
        end
        object.singleton_class.send :alias_method, field.name + "=", method_name
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