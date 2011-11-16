require 'active_support/module/aliasing'

class Class
  # Purpose is to be able to define a default value for a class_attribute when one isn't initially set.
  def class_attribute_with_default(*attrs) # Actually, this IS being used currently by gems in lib/
    hash = attrs.last.is_a?(Hash) ? attrs.pop : {}
    my_default = hash.delete(:default)
    instance_writer = hash.blank? || hash[:instance_writer]

    attrs.each do |name| # By the way, FIXME: i think this should be broken because if i want to use a string as a default, that will not be reflected.
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def self.#{name}() #{my_default || 'nil'} end
        def self.#{name}?() !!#{name} end

        def self.#{name}=(val)
          singleton_class.class_eval do
            remove_possible_method(:#{name})
            define_method(:#{name}) { val }
          end
          val
        end

        def #{name}
          defined?(@#{name}) ? @#{name} : singleton_class.#{name}
        end

        def #{name}?
          !!#{name}
        end
      RUBY

      attr_writer name if instance_writer
    end
  end
  alias_method_chain :class_attribute, :default
end
