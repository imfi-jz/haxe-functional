package nl.imfi_jz.test.functional.correctness.testcase;

import utest.Assert;
import nl.imfi_jz.test.functional.correctness.Data;
import nl.imfi_jz.functional.collection.Collection;

class Map extends utest.Test {
    function testSortedArrayAddOneToEven(){
        var collection:Multitude<Int> = Data.sortedArray0To10();
        collection = collection.map((value)->Function.isEven(value) ? value + 1 : value);
        final mappedArray = Data.sortedArray0To10().map((value)->Function.isEven(value) ? value + 1 : value);

        for(num in collection){
            Assert.isFalse(Function.isEven(num));
            Assert.contains(num, mappedArray);
        }
        Assert.equals(Data.sortedArray0To10().length, collection.length);
        Assert.equals(mappedArray.length, collection.length);
    }

    function testSortedStringMapAddOneToEven(){
        var collection:Pairs<String, Int> = Data.sortedStringMap0To10();
        collection = collection.map((key, value)->Function.isEven(value) ? value + 1 : value);
        final mappedArray = Data.sortedArray0To10().map((value)->Function.isEven(value) ? value + 1 : value);

        for(num in collection){
            Assert.isFalse(Function.isEven(num));
            Assert.contains(num, mappedArray);
        }
        Assert.equals(Data.sortedArray0To10().length, collection.length);
        Assert.equals(mappedArray.length, collection.length);
    }

    function testSortedIntMapAddOneToEven(){
        var collection:Multitude<Int> = Data.sortedIntMap0To10();
        collection = collection.map((value)->Function.isEven(value) ? value + 1 : value);
        final mappedArray = Data.sortedArray0To10().map((value)->Function.isEven(value) ? value + 1 : value);

        for(num in collection){
            Assert.isFalse(Function.isEven(num));
            Assert.contains(num, mappedArray);
        }
        Assert.equals(Data.sortedArray0To10().length, collection.length);
        Assert.equals(mappedArray.length, collection.length);
    }

    function testSortedObjectMapAddOneToEven(){
        var collection:Pairs<TestObject, Int> = Data.sortedObjectMap0To10();
        collection = collection.map((key, value)->Function.isEven(value) ? value + 1 : value);
        final mappedArray = Data.sortedArray0To10().map((value)->Function.isEven(value) ? value + 1 : value);

        for(num in collection){
            Assert.isFalse(Function.isEven(num));
            Assert.contains(num, mappedArray);
        }
        Assert.equals(Data.sortedArray0To10().length, collection.length);
        Assert.equals(mappedArray.length, collection.length);
    }

    function testSortedObjectMapChained(){
        var collection:Pairs<TestObject, Int> = Data.sortedObjectMap0To10();
        collection = collection.map((key, value)->Function.isEven(value) ? value + 1 : value).map((key, value)->cast(value / 2));
        final mappedArray = Data.sortedArray0To10().map((value)->Function.isEven(value) ? value + 1 : value).map((value)->cast(value / 2));

        for(num in collection){
            Assert.contains(num, mappedArray);
        }
        Assert.equals(Data.sortedArray0To10().length, collection.length);
        Assert.equals(mappedArray.length, collection.length);
    }

    function testSortedListAddOneToEven(){
        var collection:Multitude<Int> = Data.sortedList0To10();
        collection = collection.map((value)->Function.isEven(value) ? value + 1 : value);
        final mappedArray = Data.sortedArray0To10().map((value)->Function.isEven(value) ? value + 1 : value);

        for(num in collection){
            Assert.isFalse(Function.isEven(num));
            Assert.contains(num, mappedArray);
        }
        Assert.equals(Data.sortedArray0To10().length, collection.length);
        Assert.equals(mappedArray.length, collection.length);
    }
}