package nl.imfi_jz.test.functional.correctness.testcase;

import nl.imfi_jz.functional.collection.Collection;
import utest.Assert;

class Sort extends utest.Test {
    function ignored_testArrayBackwards() {
        var collection:Multitude<Int> = Data.sortedArray0To10();
        //collection = collection.sort((k1, k2, v1, v2)->v2 - v1);
        final sortedArray = Data.sortedArray0To10();
        sortedArray.sort((a, b)->b - a);
        
        for(key => value in collection){
            Assert.equals(sortedArray[key], value);
        }
    }
}