package nl.imfi_jz.test.functional.performance.testcase;

import nl.imfi_jz.test.functional.performance.Data;

class Map extends utest.Test {
    function testIntArray(){
        Function.measurementReport("MapIntArray", ()->Data.intArray.map(Function.map));
    }

    function testStringMap(){
        Function.measurementReport("MapStringMap", ()->Data.stringIntMap.map((key, value)->Function.map(value)));
    }

    #if !functional_mutable
    function testIntList(){
        Function.measurementReport("MapIntList", ()->Data.intList.map(Function.map));
    }
    #end
}