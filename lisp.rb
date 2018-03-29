# frozen_string_literal: true

require 'pp'
require './lexer'
require './parser'

def main(code)
  tokens = Lexer.new.tokenize(code)
  syntax_tree = Parser.parse(tokens)
  puts 'Code'
  puts '----'
  puts code
  puts ''
  puts 'Abstract syntax tree'
  puts '--------------------'
  pp syntax_tree
end

if ARGV.length == 1
  code_filename = ARGV[0]
  File.open(code_filename) do |code_file|
    main(code_file.read)
  end
elsif ARGV.length == 2 && ARGV[0] == '-e'
  code = ARGV[1]
  main(code)
else
  puts 'Usage: ruby lisp.rb <lisp-code-file>'
  puts '       ruby lisp.rb -e <lisp-code>'
  exit 1
end
