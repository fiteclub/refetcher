module Utils
  def human_call(method, *args)
    sleep rand(1.0..3.1)
    send(method.to_sym, *args)
  end
end