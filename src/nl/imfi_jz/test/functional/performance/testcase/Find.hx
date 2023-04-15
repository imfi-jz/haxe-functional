package nl.imfi_jz.test.functional.performance.testcase;

import nl.imfi_jz.test.functional.performance.Data.Function;

class Find extends utest.Test {
    function testIntArray(){
        Function.measurementReport("FindIntArray", ()->Data.intArray.find(Function.find));
    }

    function testStringMap(){
        Function.measurementReport("FindStringMap", ()->Data.stringIntMap.find((key, value)->Function.find(value)));
    }

    #if !functional_mutable
    function testIntList(){
        Function.measurementReport("FindIntList", ()->Data.intList.find(Function.find));
    }
    #end
}