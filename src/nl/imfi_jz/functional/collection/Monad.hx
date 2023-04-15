package nl.imfi_jz.functional.collection;

interface Monad<T> {
    function flatmap(fn:(value:T)->T):Functor<T>;
}