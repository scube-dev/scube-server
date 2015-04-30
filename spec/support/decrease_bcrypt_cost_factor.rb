module BCrypt
  class Engine
    remove_const  :DEFAULT_COST
    const_set     :DEFAULT_COST, 4
  end
end
