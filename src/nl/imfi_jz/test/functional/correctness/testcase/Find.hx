package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.test.functional.correctness.Data;
import nl.imfi_jz.functional.collection.Collection;
import utest.Assert;
import utest.Test;

class Find extends Test {
    function testSortedArrayEven() {
        final collection:Multitude<Int> = Data.sortedArray0To10();

        Assert.contains(collection.find(Function.isEven).value, collection);
    }
    
    function testSortedStringMapEven() {
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();

        Assert.contains(collection.find((key, value)->Function.isEven(value)).value, collection);
    }
    
    function testSortedStringArrayCapital() {
        final collection:Multitude<String> = Data.sortedArrayZeroToTen();

        Assert.contains(collection.find(Function.startsWithUpperCase).value, collection);
    }

    function testSortedListEven() {
        final collection:Multitude<Int> = Data.sortedList0To10();

        Assert.contains(collection.find(Function.isEven).value, collection);
    }

    function testKeyIsNotEqualToValue() {
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();

        Assert.isFalse(Std.string(collection.find((key, value)->Function.isEven(value)).value) == collection.find((key, value)->Function.isEven(value)).key);
        Assert.equals(collection.find((key, value)->Function.isEven(value)).value, collection.find((key, value)->Function.isEven(value)).value);

        collection.each((key, value)->{
            Assert.isOfType(key, String);
            Assert.isOfType(value, Int);
        });
    }
}