require "treetop"

module Conditions
  def conditions
    elements.inject([]) do |conditions, element|
      case conditions
      when Conditions
        conditions.push(*element.conditions)
      when Condition
        condition << element
      end
    end
  end
end

class Condition < Treetop::Runtime::SyntaxNode; end
class BelongingToCondition < Condition; end
class OfCondition < Condition; end
class ArrowCondition < Condition; end

Treetop.load File.expand_path(File.dirname(__FILE__) + "/conditions.treetop")



class Treetop::Runtime::SyntaxNode
  def node_name
    extension_modules[0].name rescue "XXX"
  end
  
  def path(indent=0)
    if nonterminal?
      elements.each do |x|
        puts(" " * indent + "#{node_name}")
        x.path(indent + 2)
      end
    end
  end
end
