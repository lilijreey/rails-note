module SS
aa=3
  def self.set_aa(n)
    @aa = n
  end

  def self.ss()
    puts "aa:"  @aa
  end

  def self.set_self_aa(n)
    self.aa = n
  end 

  def self.self_aa()
    aa=3
    puts self.aa
  end

end

SS.self_aa()
