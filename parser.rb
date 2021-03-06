# frozen_string_literal: true

class Parser
  def self.parse(tokens)
    tokens_after_parse, list_node = ListNode.parse(tokens)
    list_node if tokens_after_parse&.empty?
  end
end

class IntegerNode
  def initialize(token)
    @token = token
  end

  def eval
    @token.string.to_i
  end

  def self.parse(tokens)
    tokens, next_token = tokens.next
    return nil unless next_token.is_a?(IntegerToken)
    [tokens, new(next_token)]
  end
end

class NameNode
  def initialize(token)
    @token = token
  end

  def eval
    @token.string.to_sym
  end

  def self.parse(tokens)
    tokens, next_token = tokens.next
    return nil unless next_token.is_a?(Name)
    [tokens, new(next_token)]
  end
end

class ListNode
  ELEMENT_PRODUCTIONS = [ListNode, IntegerNode, NameNode].freeze

  def initialize(elements)
    @elements = elements
  end

  def eval
    function_name = @elements.first
    arguments = @elements.drop(1)
    evald_arguments = arguments.map(&:eval)
    function = function_name.eval.to_proc
    function.call(*evald_arguments)
  end

  def self.parse(tokens)
    elements = []
    tokens, next_token = tokens.next
    return nil unless next_token.is_a?(OpenParens)
    until tokens.peek.is_a?(CloseParens) || tokens.empty?
      tokens, parse_node = next_parse_node(tokens)
      return nil unless parse_node
      elements << parse_node
    end
    tokens, next_token = tokens.next
    return nil unless next_token.is_a?(CloseParens)
    [tokens, new(elements)]
  end

  def self.next_parse_node(tokens)
    tokens_after_parse = nil
    parse_node = nil
    ELEMENT_PRODUCTIONS.each do |production|
      tokens_after_parse, parse_node = production.parse(tokens)
      break if parse_node
    end
    [tokens_after_parse, parse_node]
  end
end
