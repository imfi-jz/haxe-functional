package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.test.functional.correctness.Data.TestObject;
import nl.imfi_jz.functional.collection.Collection.Pairs;
import utest.Assert;
import nl.imfi_jz.functional.collection.Collection.Multitude;

class Any extends utest.Test {
    function testSortedArray() {
        final collection:Multitude<Int> = Data.sortedArray0To10();
        final emptyCollection:Multitude<Int> = [];

        Assert.isTrue(collection.any());
        Assert.isFalse(emptyCollection.any());
    }
    
    function testSortedIntMap() {
        final collection:Multitude<Int> = Data.sortedIntMap0To10();
        final emptyCollection:Multitude<Int> = new haxe.ds.Map<Int, Int>();

        Assert.isTrue(collection.any());
        Assert.isFalse(emptyCollection.any());
    }
    
    function testSortedStringMap() {
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();
        final emptyCollection:Pairs<String, Int> = new haxe.ds.Map<String, Int>();

        Assert.isTrue(collection.any());
        Assert.isFalse(emptyCollection.any());
    }
    
    function testSortedObjectMap() {
        final collection:Pairs<TestObject, Int> = Data.sortedObjectMap0To10();
        final emptyCollection:Pairs<TestObject, Int> = new haxe.ds.Map<TestObject, Int>();

        Assert.isTrue(collection.any());
        Assert.isFalse(emptyCollection.any());
    }

    function testSortedList() {
        final collection:Multitude<Int> = Data.sortedList0To10();
        final emptyCollection:Multitude<Int> =
        #if functional_mutable
        [];
        #else
        new List<Int>();
        #end

        Assert.isTrue(collection.any());
        Assert.isFalse(emptyCollection.any());
    }
}