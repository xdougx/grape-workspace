class User
  
  def greet name
    message = { message: "Hello, how doing #{name}?" }
    ap message.as_json
    message
  end

  def congrat name
    message = { message: "Congratulations dear #{name}, im impressed with your done" }
  end
end