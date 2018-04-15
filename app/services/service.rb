class Service
  class << self
    def call *args
      new(*args).call
    end
  end

  def save?
    !!@save
  end
end
