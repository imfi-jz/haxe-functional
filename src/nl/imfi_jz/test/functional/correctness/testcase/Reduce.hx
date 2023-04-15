package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.test.functional.correctness.Data;
import utest.Assert;
import nl.imfi_jz.functional.collection.Collection;

class Reduce extends utest.Test {
    private static inline function function1(mod:Int, value:Int):Int {
        return Math.floor((mod + value) / 2);
    }

    private static function function2(mod:Multitude<Int>, value:Int):Multitude<Int> {
        if(value * value != value){
            final next:Array<Int> = mod;
            next.push(value * value);
        }
        return mod;
    }

    function testFunction1OnSortedArray() {
        final collection:Multitude<Int> = Data.sortedArray0To10();
        final reduced = collection.reduce(1, function1);

        Assert.equals(9, reduced);
    }

    function testFunction2OnSortedArray() {
        final collection:Multitude<Int> = Data.sortedArray0To10();
        final reduced = collection.reduce(Multitude.empty(), function2);

        Assert.notContains(0, reduced);
        for(i in 1...reduced.length){
            Assert.contains(i * i, reduced);
        }
    }

    function testFunction2OnSortedMaps() {
        final collectionFromIntMap:Multitude<Int> = Data.sortedIntMap0To10();
        final reducedIntMap = collectionFromIntMap.reduce(Multitude.empty(), function2);
        final function2WithKey = (mod, key, fn)->function2(mod, fn);
        final collectionFromStringMap:Pairs<String, Int> = Data.sortedStringMap0To10();
        final reducedStringMap = collectionFromStringMap.reduce(Pairs.empty(), cast function2WithKey);
        final collectionFromObjectMap:Pairs<String, Int> = Data.sortedStringMap0To10();
        final reducedObjectMap = collectionFromObjectMap.reduce(Pairs.empty(), cast function2WithKey);

        Assert.notContains(0, reducedIntMap);
        Assert.notContains(0, reducedStringMap);
        Assert.notContains(0, reducedObjectMap);
        Assert.equals(reducedIntMap.length, reducedStringMap.length);
        Assert.equals(reducedIntMap.length, reducedObjectMap.length);
        for(i in 1...reducedIntMap.length){
            Assert.contains(i * i, reducedIntMap);
            Assert.contains(i * i, reducedStringMap);
            Assert.contains(i * i, reducedObjectMap);
        }
    }
}