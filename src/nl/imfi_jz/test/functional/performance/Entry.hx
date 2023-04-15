package nl.imfi_jz.test.functional.performance;

import nl.imfi_jz.functional.collection.Collection.Multitude;
import nl.imfi_jz.test.functional.performance.Data.Function;
import utest.ui.Report;
import utest.Runner;

class Entry {
    static function main() {
        traceCurrentTarget();
        traceFunctionalCompilationFlags();

        final runner = new Runner();
        runner.addCases(nl.imfi_jz.test.functional.performance.testcase);

        final startTimeMs = haxe.Timer.stamp();
        runner.run();
        final totalRunningTimeMs = haxe.Timer.stamp() - startTimeMs;

        // Print average measurement
        final measurements:Multitude<Float> = Function.allMeasurements;
        final report = "

        Average: " + measurements.reduce(0.0, (mod, ms)->mod + ms) / measurements.length + "ms per function call
        Total running time: " + totalRunningTimeMs + "ms";
        trace(report);
        #if js js.Syntax.code("document.write('<br><br>')");
        js.Syntax.code("document.write({0})", report);
        #end
    }

    static function traceFunctionalCompilationFlags() {
        #if no_functional_inline
        trace("no functional inline");
        #if js js.Syntax.code("document.write('no functional inline <br><br>')");
        #end
        #end #if functional_mutable
        trace("functional mutable");
        #if js js.Syntax.code("document.write('functional mutable <br><br>')");
        #end
        #end
    }

    static function traceCurrentTarget() {
        #if js trace("js");
        #elseif php trace("php");
        #elseif cpp trace("cpp");
        #elseif jvm trace("jvm");
        #elseif java trace("java");
        #elseif python trace("python");
        #elseif neko trace("neko");
        #elseif flash trace("flash");
        #elseif swf trace("swf");
        #elseif cs trace("cs");
        #elseif lua trace("lua");
        #elseif hl trace("hl");
        #elseif macro trace("macro");
        #elseif eval trace("eval");
        #end
    }
}