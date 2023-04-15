package nl.imfi_jz.test.functional.correctness;

import utest.utils.Macro;
import nl.imfi_jz.test.functional.correctness.testcase.Sort;
import utest.ui.Report;
import utest.Runner;

class Entry {
    static function main() {
        traceCurrentTarget();
        traceFunctionalCompilationFlags();

        final runner = new Runner();
        runner.addCases(nl.imfi_jz.test.functional.correctness.testcase);

        Report.create(runner);
        runner.run();
    }

    static function traceFunctionalCompilationFlags() {
        #if no_functional_inline
        trace("no functional inline");
        #end #if functional_mutable
        trace("functional mutable");
        #end
    }

    static function traceCurrentTarget() {
        #if js 
        trace("js");
        #elseif php
        trace("php");
        #elseif cpp
        trace("cpp");
        #elseif jvm
        trace("jvm");
        #elseif java
        trace("java");
        #elseif python
        trace("python");
        #elseif neko
        trace("neko");
        #elseif flash
        trace("flash");
        #elseif swf
        trace("swf");
        #elseif cs
        trace("cs");
        #elseif lua
        trace("lua");
        #elseif hl
        trace("hl");
        #elseif macro
        trace("macro");
        #elseif eval
        trace("eval");
        #end
    }
}