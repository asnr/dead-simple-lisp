# frozen_string_literal: true

class TokenStream
  def initialize(tokens: nil, head_index: nil)
    @tokens = tokens || []
    @head_index = head_index || 0
  end

  def empty?
    @head_index >= @tokens.size
  end

  def <<(token)
    @tokens << token unless token.is_a?(Whitespace)
  end

  def next
    next_token = @tokens[@head_index]
    new_stream = TokenStream.new(tokens: @tokens, head_index: @head_index + 1)
    [new_stream, next_token]
  end

  def peek
    @tokens[@head_index]
  end
end
