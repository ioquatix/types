# Types

Provides abstract types for the Ruby programming language which can used for documentation and evaluation purposes.

## Motivation

I've been working on documentation tools and Ruby has several implementations for adding type information. However, I've feel like we've over-complicated the language of types and I'd like something simpler and more compatible with the Ruby language.

The original design started in [bake](https://github.com/ioquatix/bake) which uses `@parameter name [Signature] description` comments to document the types of parameters. The command-line interface of bake uses the type signature to coerce string arguments to the desired type. This has been a useful strategy to reduce code duplication and to make the code more readable.

Subsequently, I started using these type signatures in [decode](https://github.com/ioquatix/decode) which uses similar `@parameter` comments. This information is fed into [utopia-project](https://github.com/socketry/utopia-project) which can present this information as part of the generated documentation.

The expressions possible with this gem are a subset of all possible expressions in Ruby's type system. This is by design. At some point in the future, it is likely we will automate conversion of type signatures to the RBS compatible type signature files. This will allow us to use the same type signatures in the documentation and in the code.

## Installation

```shell
bundle add types
```

## Usage

Parsing type signatures can be done using {ruby Types.parse} which returns a object that represents the given type, e.g.

```ruby
string_type = Types.parse("String")
string_type # => Types::String

array_type = Types.parse("Array(String)")
array_type.class # => Types::Array

hash_type = Types.parse("Hash(String, Integer)")
hash_type.key_type # => Types::String
hash_type.value_type # => Types::Integer
```

You can generate a string representation of a type too:

```ruby
# A lambda that takes an Integer as an argument and returns an Integer:
lambda_type = Types.parse("Lambda(Integer, returns: Integer)")
lambda_type.to_s # => "Lambda(Integer, returns: Integer)"
```

### String Parsing

In addition, you can coerce strings into strongly typed values:

```ruby
array_type = Types.parse("Array(String)")
array_type.parse("'foo', 'bar'") # => ["foo", "bar"]
```

This can be useful for argument parsing.

### Documentation

This gem is designed to be integrated into documentation tools. It provides a way to document the types of parameters and return values of a function. This information is stored in `@parameter` and `@returns` comments.

```ruby
# Double the value of a number.
# @parameter value [Numeric] The value to double.
# @returns [Numeric] The doubled value.
def double(value)
	return value * 2
end
```

The motivation for discrete parameter and return types is to make integration with documentation tools easier. Specifically, language servers can use this information to provide context sensitive type information and documentation which is hard to do with existing formats like `rdoc`.