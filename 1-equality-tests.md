## ==

The == operator tests if the values the same, ignoring the class of each object

    1.9.3p0 > 'a' == 'a'
      => true
    1.9.3p0 > 1.0 == 1
      => true

    1.9.3p0 > Object.new == Object.new
      => false


## =~ and !~

Redefined by Regexp class to alias the match method

    1.9.3p0 > /cats/ =~ 'no cats here'                                                                                                                      =>
      => 3
    1.9.3p0 > /cats/ !~ 'no cats here'
      => false


## ===

The === operator is similar to ==

    1.9.3p0 > 'a' === 'a'
      => true
    1.9.3p0 > 1.0 === 1
      => true

But also returns true when the LHS expressions class matches the RHS class

    1.9.3p0 :025 > Fixnum === 1
      => true
    1.9.3p0 :026 > Float === 1
      => false
    1.9.3p0 :027 > Array === [1,2,3]
      => true
    1.9.3p0 :028 > 1 === Fixnum
      => false

This is useful in case expressions

    case obj
      when Array          then
      when Fixnum, Float  then
      when Hash           then
      when 1..10          then
      when /some|regex/   then
    end


## eql?

The eql? operator tests for equality in value and class

    1.9.3p0 > 'a'.eql? 'a'
      => true

    1.9.3p0 > 1.eql? 1.0
      => false

    1.9.3p0 > Object.new.eql? Object.new
      => false


## equal?

The equal? operator looks for the objects being tested to be the same in memory

    1.9.3p0 > 'a'.equal? 'a'
      => false
    1.9.3p0 > 1.equal? 1.0
       => false

Symbols and Fixnum both have one instance in memory for each possible value, for performance and other reasons

    1.9.3p0 > :a.equal? :a
      => true
    1.9.3p0 > 1.equal? 1
      => true

    1.9.3p0 > Object.new.equal? Object.new
      => false

### References

http://rubylearning.com/blog/2010/11/17/does-ruby-have-too-many-equality-tests/
