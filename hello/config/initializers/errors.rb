class Mongoid::Errors::DocumentNotFound < Mongoid::Errors::MongoidError
  def error
    {
      error: {
        message: "Document hasnt been founded"
      }
    }
  end

  def status
    404
  end
end

Exception.class_eval do
  def error
    { 
      error: { 
        message: self.message,
        full_message: "Ocorreu algum erro inesperado."
      }
    }
  end

  def status
    400
  end
end