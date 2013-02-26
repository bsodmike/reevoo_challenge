class Rule
  attr_accessor :rules
  def initialize(rules = [])
    @rules = rules
  end

  def add_rule(rule)
    raise RuleFormatError, "Rules must be defined as Hash!" unless rule.class == Hash
    @rules << rule
  end

  def all
    @rules
  end

end

class RuleFormatError < StandardError; end
