# frozen_string_literal: true

require './lexer'

class Parser
  def self.parse(tokens)
    tokens_after_parse, list_node = ListNode.parse(tokens)
    nil unless tokens_after_parse.empty?
    list_node
  end
end

class IntegerNode
  def initialize(token)
    @token = token
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

  def self.parse(tokens)
    elements = []
    tokens, next_token = tokens.next
    return nil unless next_token.is_a?(OpenParens)
    until tokens.peek.is_a?(CloseParens) || tokens.peek.nil?
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
