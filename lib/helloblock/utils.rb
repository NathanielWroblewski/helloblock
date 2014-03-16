module HelloBlock::Utils
  def mattr_accessor(*syms)
    syms.each do |sym|
      mattr_reader(sym)
      mattr_writer(sym)
    end
  end

  def mattr_reader(sym)
    module_eval("def #{sym}; @#{sym}; end")
  end

  def mattr_writer(sym)
    module_eval("def #{sym}=(obj); @#{sym} = obj; end")
    module_eval("@#{sym} = nil unless defined? @#{sym}")
  end
end
