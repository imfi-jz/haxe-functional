package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.test.functional.correctness.Data.TestObject;
import nl.imfi_jz.functional.collection.Collection;
import utest.Assert;

class At extends utest.Test {
    function testSortedArray() {
        final collection:Multitude<Int> = Data.sortedArray0To10();

        for(val in Data.sortedArray0To10()){
            Assert.equals(val, collection[val]);
        }
    }
    
    function testSortedIntMap() {
        final collection:Multitude<Int> = Data.sortedIntMap0To10();

        for(i in 0...Data.sortedArray0To10().length){
            Assert.equals(i, collection[Data.sortedIntMap0To10()[i]]);
        }
    }
    
    function testSortedStringMap() {
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();

        for(i in 0...Data.sortedArrayZeroToTen().length){
            Assert.equals(i, collection[Data.sortedArrayZeroToTen()[i]]);
        }
    }
    
    function testSortedObjectMap() {
        final collection:Pairs<TestObject, Int> = Data.sortedObjectMap0To10();

        for(key in Data.sortedObjectMap0To10().keys()){
            Assert.equals(Data.sortedObjectMap0To10().get(key), collection[key]);
        }
    }

    function testSortedList() {
        final collection:Multitude<Int> = Data.sortedList0To10();

        for(val in Data.sortedList0To10()){
            Assert.equals(val, collection[val]);
        }
    }
}