package nl.imfi_jz.test.functional.correctness;

import nl.imfi_jz.test.functional.performance.Entry;
import haxe.ds.List;

typedef TestObject = {
    final intValue:Int;
    final strValue:String;
    final boolValue:Bool;
}

class Data {
    private static final testObject0:TestObject = {intValue: 0, strValue: "Zero", boolValue: true};
    private static final testObject1:TestObject = {intValue: 1, strValue: "One", boolValue: false};
    private static final testObject2:TestObject = {intValue: 2, strValue: "Two", boolValue: true};
    private static final testObject3:TestObject = {intValue: 3, strValue: "Three", boolValue: false};
    private static final testObject4:TestObject = {intValue: 4, strValue: "Four", boolValue: true};
    private static final testObject5:TestObject = {intValue: 5, strValue: "Five", boolValue: false};
    private static final testObject6:TestObject = {intValue: 6, strValue: "Six", boolValue: true};
    private static final testObject7:TestObject = {intValue: 7, strValue: "Seven", boolValue: false};
    private static final testObject8:TestObject = {intValue: 8, strValue: "Eight", boolValue: true};
    private static final testObject9:TestObject = {intValue: 9, strValue: "Nine", boolValue: false};
    private static final testObject10:TestObject = {intValue: 10, strValue: "Ten", boolValue: true};

    public static final sortedArray0To10 = ()->[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    public static final sortedArrayZeroToTen = ()->["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
    public static final sortedIntMap0To10 = ()->[0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10];
    public static final sortedStringMap0To10 = ()->["Zero" => 0, "One" => 1, "Two" => 2, "Three" => 3, "Four" => 4, "Five" => 5, "Six" => 6, "Seven" => 7, "Eight" => 8, "Nine" => 9, "Ten" => 10];
    public static final sortedObjectMap0To10 = ()->[testObject0 => 0, testObject1 => 1, testObject2 => 2, testObject3 => 3, testObject4 => 4, testObject5 => 5, testObject6 => 6, testObject7 => 7, testObject8 => 8, testObject9 => 9, testObject10 => 10];
    public static final sortedList0To10 = ()->{
        #if functional_mutable return sortedArray0To10();
        #else
        final list = new List();
        for(i in 0...11){
            list.add(i);
        }
        return list;
        #end
    }
}

class Function {
    public static function isEven(number:Int){
        return number % 2 == 0;
    }

    public static function startsWithUpperCase(letter:String){
        final firstLetter = letter.substring(0, 1);
        return firstLetter.toUpperCase() == firstLetter;
    }

    public static function multipliedIntValue(obj:TestObject, multiplier = 2){
        return obj.intValue * multiplier;
    }
}