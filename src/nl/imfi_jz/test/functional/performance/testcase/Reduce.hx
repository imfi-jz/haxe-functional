package nl.imfi_jz.test.functional.performance.testcase;

import nl.imfi_jz.test.functional.performance.Data;

class Reduce extends utest.Test {
    private static inline final STARTING_MODIFIER = Math.floor(Data.NUMBER_OF_ITEMS_PER_COLLECTION / 2);

    function testIntArray(){
        Function.measurementReport("ReduceIntArray", ()->Data.intArray.reduce(STARTING_MODIFIER, Function.reduce));
    }

    function testStringMap(){
        Function.measurementReport("ReduceStringMap", ()->Data.stringIntMap.reduce(STARTING_MODIFIER, (modifier, key, value)->Function.reduce(modifier, value)));
    }

    #if !functional_mutable
    function testIntList(){
        Function.measurementReport("ReduceIntList", ()->Data.intList.reduce(STARTING_MODIFIER, Function.reduce));
    }
    #end
}