module TestRocket
  extend Module.new { attr_accessor :out }
  
  def _test(a, b)
    send((call rescue()) ? a : b)
  end
  
  def launched?
    !!($launched rescue())
  end

  def +@; r = _test :_pass, :_fail; (TestRocket.out || $>) << r; r end
  def -@; r = _test :_fail, :_pass; (TestRocket.out || $>) << r; r end
  def ~@; r = _pend;                (TestRocket.out || $>) << r; r end
  def !@; r = _desc;                (TestRocket.out || $>) << r; r end
  
  def _pass; ($targets += 1; $hits += 1) if launched?; "    OK\n"; end
  def _fail; ($targets += 1)             if launched?; "    FAIL @ #{source_location.join(':')}\n"; end
  def _pend; ($targets += 1; $lost += 1) if launched?; "    PENDING '#{call.to_s}' @ #{source_location.join(':')}\n"; end
  def _desc;                                           "  FIRE '#{call.to_s}'!\n"; end

end
Proc.send :include, TestRocket

