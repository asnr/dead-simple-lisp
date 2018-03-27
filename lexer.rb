# frozen_string_literal: true

require 'strscan'
require './tokens'
require './token_stream'

class Lexer
  TOKEN_TYPES = [OpenParens, CloseParens, Name, IntegerToken, Whitespace].freeze

  def tokenize(code)
    tokens = TokenStream.new
    scanner = StringScanner.new(code)
    until scanner.eos?
      next_token = match_against_token_types(scanner)
      raise StandardError, "Token unknown at #{scanner.pos}" unless next_token
      tokens << next_token
    end
    tokens
  end

  private

  def match_against_token_types(scanner)
    position = scanner.pos
    TOKEN_TYPES.each do |type|
      token = type.match(scanner, position)
      return token if token
    end
    nil
  end
end
