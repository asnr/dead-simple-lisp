# frozen_string_literal: true

class Token
  attr_reader :string
  def initialize(string, index_in_code)
    @string = string
    @index_in_code = index_in_code
  end

  def length
    string.length
  end

  def self.match(scanner, position)
    token_string = scanner.scan(self::REGEX)
    new(token_string, position) if token_string
  end
end

class OpenParens < Token
  REGEX = /[(]/
end

class CloseParens < Token
  REGEX = /[)]/
end

class Name < Token
  REGEX = %r{([[:alpha:]][[:alnum:]-]*)|\+|-|\*|/}
end

class IntegerToken < Token
  REGEX = /-?[[:digit:]]+/
end

class Whitespace < Token
  REGEX = /[[:space:]]+/
end
