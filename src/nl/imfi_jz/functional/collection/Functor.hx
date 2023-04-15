package nl.imfi_jz.functional.collection;

interface Functor<T> {
    function map(fn:(value:T)->T):Functor<T>;
}