require "treetop"

class SplitConditions < Treetop::Runtime::SyntaxNode
  def splited_conditions
    elements.inject([]) do |conditions, element|
      case element
      when SplitConditions
        conditions.push(*element.splited_conditions)
      when Condition
        conditions << element
      end
      conditions
    end
  end
end
class CommaAndConditions < SplitConditions; end
class CommaConditions < SplitConditions; end
class AndConditions < SplitConditions; end

class Condition < Treetop::Runtime::SyntaxNode; end
class BelongingToCondition < Condition; end
class OfCondition < Condition; end
class ArrowCondition < Condition; end

Treetop.load File.expand_path(File.dirname(__FILE__) + "/conditions.treetop")
