package nl.imfi_jz.test.functional.performance.testcase;

import nl.imfi_jz.test.functional.performance.Data.Function;

class Filter extends utest.Test {
    function testIntArray(){
        Function.measurementReport("FilterIntArray", ()->Data.intArray.filter(Function.filter));
    }

    function testStringIntMap(){
        Function.measurementReport("FilterStringMap", ()->Data.stringIntMap.filter((key, value)->Function.filter(value)));
    }

    #if !functional_mutable
    function testIntList(){
        Function.measurementReport("FilterIntList", ()->Data.intList.filter(Function.filter));
    }
    #end
}