package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.test.functional.correctness.Data;
import utest.Assert;
import nl.imfi_jz.functional.collection.Collection;

class Iteration extends utest.Test {
    function testSortedArrayIteration(){
        final collection:Multitude<Int> = Data.sortedArray0To10();
        final sortedIterator = Data.sortedArray0To10().iterator();
        var iterations = 0;

        for(num in collection){
            Assert.equals(sortedIterator.next(), num);
            iterations++;
        }
        Assert.equals(Data.sortedArray0To10().length, iterations);
    }

    function testSortedStringMapValueIteration(){
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();
        var iterations = 0;

        for(val in collection){
            Assert.contains(val, Data.sortedArray0To10());
            iterations++;
        }
        Assert.equals(Data.sortedArray0To10().length, iterations);
    }

    function testSortedStringMapKeyValueIteration(){
        final collection:Pairs<String, Int> = Data.sortedStringMap0To10();
        var iterations = 0;

        for(key => value in collection){
            Assert.contains(key, Data.sortedArrayZeroToTen());
            Assert.contains(value, Data.sortedArray0To10());
            iterations++;
        }
        Assert.equals(Data.sortedArray0To10().length, iterations);
    }

    function testSortedIntMapKeyValueIteration(){
        final collection:Multitude<Int> = Data.sortedIntMap0To10();
        var iterations = 0;

        for(key => value in collection){
            Assert.contains(key, Data.sortedArray0To10());
            Assert.contains(value, Data.sortedArray0To10());
            iterations++;
        }
        Assert.equals(Data.sortedArray0To10().length, iterations);
    }

    function testSortedObjectMapKeyValueIteration(){
        final collection:Pairs<TestObject, Int> = Data.sortedObjectMap0To10();
        final keysArray = [];
        for(key in Data.sortedObjectMap0To10().keys()){
            keysArray.push(key);
        }
        var iterations = 0;

        for(key => value in collection){
            Assert.contains(key, keysArray);
            Assert.contains(value, Data.sortedArray0To10());
            iterations++;
        }
        Assert.equals(Data.sortedArray0To10().length, iterations);
    }

    function testSortedListIteration(){
        final collection:Multitude<Int> = Data.sortedList0To10();
        final sortedIterator = Data.sortedList0To10().iterator();
        var iterations = 0;

        for(num in collection){
            Assert.equals(sortedIterator.next(), num);
            iterations++;
        }
        Assert.equals(Data.sortedArray0To10().length, iterations);
    }
}