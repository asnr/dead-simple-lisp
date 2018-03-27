# frozen_string_literal: true

require './lexer'
require './parser'

if ARGV.length != 1
  puts 'Usage: ruby lisp.rb lisp_code_file'
  exit 1
end

code_filename = ARGV[0]

File.open(code_filename) do |code_file|
  code = code_file.read
  tokens = Lexer.new.tokenize(code)
  syntax_tree = Parser.parse(tokens)
  puts 'Code:'
  puts '-----'
  puts code
  puts ''
  puts 'Abstract syntax tree:'
  puts '---------------------'
  p syntax_tree
end
