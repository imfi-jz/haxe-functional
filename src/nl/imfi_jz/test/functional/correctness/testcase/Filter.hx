package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.test.functional.correctness.Data;
import utest.Assert;
import nl.imfi_jz.functional.collection.Collection;

class Filter extends utest.Test {
    function testSortedArrayAbove5() {
        final collection:Multitude<Int> = Data.sortedArray0To10();
        final filteredCollection = collection.filter((value)->value > 5);
        final filteredArray = Data.sortedArray0To10().filter((value)->value > 5);

        Assert.equals(filteredArray.length, filteredCollection.length);
        for(value in filteredCollection){
            Assert.isTrue(value > 5);
            Assert.contains(value, filteredArray);
        }
    }

    function testSortedStringMapAbove5() {
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();
        final filtered = collection.filter((key, value)->value > 5);
        
        Assert.equals(5, filtered.length);
        for(value in filtered){
            Assert.isTrue(value > 5);
        }
    }

    function testSortedListAbove5() {
        final collection:Multitude<Int> = Data.sortedList0To10();
        final filtered = collection.filter((value)->value > 5);
        
        Assert.equals(5, filtered.length);
        for(value in filtered){
            Assert.isTrue(value > 5);
        }
    }

    function testSortedArrayEven() {
        final collection:Multitude<Int> = Data.sortedArray0To10();
        final filteredCollection = collection.filter(Function.isEven);
        final filteredArray = Data.sortedArray0To10().filter(Function.isEven);
        
        Assert.equals(filteredArray.length, filteredCollection.length);
        for(value in filteredCollection){
            Assert.isTrue(Function.isEven(value));
            Assert.contains(value, filteredArray);
        }
    }

    function testSortedArrayChained() {
        final collection:Multitude<Int> = Data.sortedArray0To10();
        final filteredCollection = collection.filter((value)->value > 5).filter(Function.isEven);
        final filteredArray = Data.sortedArray0To10().filter((value)->value > 5).filter(Function.isEven);

        Assert.equals(filteredArray.length, filteredCollection.length);
        for(value in filteredCollection){
            Assert.isTrue(value > 5);
            Assert.isTrue(Function.isEven(value));
            Assert.contains(value, filteredArray);
        }
    }

    function testSortedStringArray() {
        final collection:Multitude<String> = Data.sortedArrayZeroToTen();
        final filteredCollection = collection.filter((value)->value.indexOf("e") >= 0);
        final filteredArray = Data.sortedArrayZeroToTen().filter((value)->value.indexOf("e") >= 0);

        Assert.equals(7, filteredCollection.length);
        Assert.equals(filteredArray.length, filteredCollection.length);
        for(value in filteredCollection){
            Assert.contains(value, filteredArray);
        }
    }
}