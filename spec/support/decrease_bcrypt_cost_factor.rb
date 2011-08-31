module BCrypt
  class Engine
    [:DEFAULT_COST, :MIN_COST].each do |sym|
      remove_const  sym
      const_set     sym, 1
    end
  end
end
