package nl.imfi_jz.test.functional.performance;

import haxe.Timer;
import nl.imfi_jz.functional.collection.Collection;

class Data {
    @:deprecated public static inline final SECONDS_OF_RUNTIME_PER_FUNCTION = 1;
    public static inline final FUNCTION_EXECUTION_COUNT = 10000;
    public static inline final NUMBER_OF_ITEMS_PER_COLLECTION = 100;

    public static final intArray:Multitude<Int> = [for(i in 0...NUMBER_OF_ITEMS_PER_COLLECTION) i];
    public static final stringIntMap:Pairs<String, Int> = [for(i in 0...NUMBER_OF_ITEMS_PER_COLLECTION) "" + i => i];
    public static final intList:Multitude<Int> = getList();

    private static function getList(){
        #if !functional_mutable
        final list = new List();
        for(i in 0...NUMBER_OF_ITEMS_PER_COLLECTION){
            list.add(i);
        }
        return list;
        #else return null;
        #end
    }
}

class Function {
    public static final allMeasurements = new Array<Float>();

    public static inline function measurementReport(functionName:String, func:Void->Void){
        final startTime = Timer.stamp();
        for(i in 0...Data.FUNCTION_EXECUTION_COUNT){
            func();
        }
        final avgMs = ((Timer.stamp() - startTime) * 1000) / Data.FUNCTION_EXECUTION_COUNT;
        final report:String = '$functionName \t ' + avgMs + 'ms';
        allMeasurements.push(avgMs);
        trace(report);
        #if js js.Syntax.code("document.write({0})", report);
        js.Syntax.code("document.write('<br>')");
        #end
    }

    public static inline function filter(value){
        return Math.random() > 0.5;
    }

    public static inline function find(value:Int){
        return value > Data.NUMBER_OF_ITEMS_PER_COLLECTION * 0.75;
    }

    public static inline function map(value:Int){
        return value * 2;
    }

    public static inline function reduce(mod:Int, value:Int){
        return value > mod ? value : mod;
    }
}