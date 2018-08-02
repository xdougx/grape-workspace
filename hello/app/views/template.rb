class Template
  attr_reader :name

  def initialize(file)
    @file = file
  end

  def build
    raw = File.read("app/views/kana/#{@file}.html.erb")
    ERB.new(raw).result(binding)
  end
end