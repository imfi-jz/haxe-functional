package nl.imfi_jz.test.functional.performance;

import haxe.Timer;

class Stopwatch {
    public function new() {

    }

    public function start(functionName:String, func:Void->Void) {
        var running = true;
        var timesExecuted = 0;
        
        Timer.delay(()->{
            running = false;
        }, Data.SECONDS_OF_RUNTIME_PER_FUNCTION * 1000);

        while(running){
            func();
            timesExecuted++;
        }

        showResult(functionName, timesExecuted);
    }

    private inline function showResult(functionName:String, timesExecuted:Int){
        trace('$functionName executed $timesExecuted times in ' + Data.SECONDS_OF_RUNTIME_PER_FUNCTION + " seconds");
        trace("Average runtime: " + (timesExecuted / Data.SECONDS_OF_RUNTIME_PER_FUNCTION) * 1000 + " ms");
    }
}