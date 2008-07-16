import 'java.lang.reflect.Modifier'

module Kernel
  def is_instance?(field)
    field.modifiers & Modifier::STATIC == 0
  end

  def is_static?(field)
    field.modifiers & Modifier::STATIC != 0
  end

  def is_instance_non_final?(field)
    (field.modifiers & Modifier::STATIC == 0) && (field.modifiers & Modifier::FINAL == 0)
  end

  def is_static_non_final?(field)
    (field.modifiers & Modifier::STATIC != 0) && (field.modifiers & Modifier::FINAL == 0)
  end

  def create_java_formatted_alias(args)
    args[:on].singleton_class.send(:alias_method, args[:called], args[:for])      
  end
end