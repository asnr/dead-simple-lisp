# Dead simple lisp

Parser uses recursive descent.

## Notes

- Recursive descent without lookahead requires your token data structure to support 'winding back'. Here I've made the `next` method on a `TokenStream` non-mutating.
- Error handling is also interesting when using a recursive descent strategy. How do you decide which of the search branches to display an error message from? Which one 'should' have succeeded?
