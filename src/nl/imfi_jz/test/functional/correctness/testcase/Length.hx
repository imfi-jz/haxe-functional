package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.test.functional.correctness.Data;
import utest.Assert;
import nl.imfi_jz.functional.collection.Collection;

class Length extends utest.Test {
    function testArrayLength() {
        final collection:Multitude<Int> = Data.sortedArray0To10();

        Assert.equals(Data.sortedArray0To10().length, collection.length);
    }
    
    function testStringMapLength() {
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();

        Assert.equals(11, collection.length);
    }
    
    function testIntMapLength() {
        final collection:Multitude<Int> = Data.sortedIntMap0To10();

        Assert.equals(11, collection.length);
    }
    
    function testObjectMapLength() {
        final collection:Pairs<TestObject, Int> = Data.sortedObjectMap0To10();

        Assert.equals(11, collection.length);
    }

    function testListLength() {
        final collection:Multitude<Int> = Data.sortedList0To10();

        Assert.equals(Data.sortedList0To10().length, collection.length);
    }
}