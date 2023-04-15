package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.functional.collection.Collection;
import utest.Assert;

class First extends utest.Test {
    function testSortedArray() {
        final collection:Multitude<Int> = Data.sortedArray0To10();

        Assert.notNull(collection.first().value);
        Assert.contains(collection.first().value, collection);
    }
    
    function testSortedStringMap() {
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();

        Assert.notNull(collection.first().value);
        Assert.contains(collection.first().value, collection);
    }
    
    function testSortedStringArrayCapital() {
        final collection:Multitude<String> = Data.sortedArrayZeroToTen();

        Assert.notNull(collection.first().value);
        Assert.contains(collection.first().value, collection);
    }

    function testSortedListEven() {
        final collection:Multitude<Int> = Data.sortedList0To10();

        Assert.notNull(collection.first().value);
        Assert.contains(collection.first().value, collection);
    }

    function testEmptyIsNull() {
        final collection:Multitude<Any> = [];

        Assert.isNull(collection.first());
    }
}