module Buildable
  extend ActiveSupport::Concern

  # build a complete update of the object
  def build_update params
    self.update_attributes(params)

    if self.valid?
      self.save
      self
    else
      raise Exceptions::Model.build(self)
    end
  end

  module ClassMethods
    # build a new user with params, raise if has errors in validation
    def build params   
      object = new params
      object.status = 'active' if object.respond_to?(:status)

      if object.valid?
        object.save
        object
      else
        raise Exceptions::Model.build(object)
      end
    end
  end
end