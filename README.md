# Haxe Functional
'Haxe Functional' (work in progress name) is a small library with a set of functions that help and extend the capabilities of writing [Haxe](https://haxe.org/) code in the functional programming paradigm. It provides functions for common functional collection operations like `filter`, `reduce`, `map` and more, and works on any collection (`Iterable`, `Array`, etc.) or map.

## Usage
Clone the repository or download it as a zip and use the source code (under /src) as a library source in your project's hxml file (see section Disclaimer).

The functions can be used on a collection by casting it to a `Multitude<T>` like so:
```haxe
final arr = [1, 2, 3];
final funcArr:Multitude<Int> = cast arr;
final noTwos = funcArr.filter((num) -> num == 2);
```
The `Multitude` type will respect the collection's order and provides functions to convert it back to various types like `Array`.

The library also works on `Maps` (key value pairs) by casting a map to a `Pairs<K, V>`, like so:
```haxe
final map = ["M" => "Monday", "T" => "Tuesday"];
final funcMap:Pairs<String, String> = cast map;
final noMondays = funcMap.filter((key, value) -> key == "M");
```

Function currying is also possible via the `abstract` `Curry` type. I forgot how exaclty this works (it's been a while since writing this code lol).

## Compilation
This library was build for Haxe version 4 and uses arrow functions all around. It should work an all compilation targets (with possibly a few exceptions).

The library can be compiled with a few different options. By default, all functional functions are inlined, resulting in potentially much less stack frames at runtime. This can be disabled with the following flag:
```hxml
-D no_functional_inline
```

To increase performance, operations (like filter, map, etc.) can be executed on the instance itself instead of returning a new instance each time. This is agains the concept of functional programming and should only be used if you are 100% sure the side effects of mutating your collections do not matter. To enable direct mutation on your collections (`Multitude` and `Pairs`) add the following flag:
```hxml
-D functional_mutable
```

## Disclaimer
I am providing this library as is, and am currently not making it an actual haxelib, as I am not 100% sure if every functional concept is implemented correctly. However, I still think this may be a useful tool to some.

Most of the functions are to some degree documented.

Do not expect regular updates for this library. If you decide to use this library I will try to provide support if you have questions. Suggestions are also welcome.