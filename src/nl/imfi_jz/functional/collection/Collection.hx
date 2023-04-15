package nl.imfi_jz.functional.collection;

import haxe.ds.ObjectMap;
import haxe.ds.StringMap;
import haxe.ds.IntMap;

typedef MapDefinition<K, V> = #if (java || hl) {
    set:(key:K, value:V)->Void,
    get:(key:K)->V,
    keyValueIterator:KeyValueIterator<K, V>
};
#else Map<K, V>;
#end

class KeyValueCollection<K, V> {
    private var lengthValue:Null<Int> = null;
    private final lengthGetter:()->Int;
    public final keyValueIterator:()->KeyValueIterator<K, V>;
    public final at:(key:K)->V;
    public final exists:(key:K)->Bool;
    public final emptyMap:()->MapDefinition<K, Any>;
    #if functional_mutable
    public var set:(key:K, value:V)->Void;
    public var remove:(key:K)->Void;
    #end

    public #if !no_functional_inline inline #end function new(
        length:()->Int,
        keyValueIterator:()->KeyValueIterator<K, V>,
        at:(key:K)->V,
        exists:(key:K)->Bool,
        ?emptyMap:()->MapDefinition<K, V>
    ) {
        lengthGetter = length;
        this.keyValueIterator = keyValueIterator;
        this.at = at;
        this.exists = exists;
        this.emptyMap = emptyMap == null
            ? ()->cast emptyMapOfTypeByRuntimeTypeChecks(cast map)
            : emptyMap;
    }

    public #if !no_functional_inline inline #end function length():Int {
        if(lengthValue == null){
            lengthValue = lengthGetter();
        }
        return lengthValue;
    }

    #if functional_mutable
    public inline function setSetFunction(set:(key:K, value:V)->Void):KeyValueCollection<K, V> {
        this.set = set;
        return this;
    }

    public inline function setRemoveFunction(remove:(key:K)->Void):KeyValueCollection<K, V> {
        this.remove = remove;
        return this;
    }
    #end

    private function toString():String {
        var str = "[";
        if(keyValueIterator != null){
            final iterator = keyValueIterator();
            for(entry in iterator){
                str += Std.string(entry.key) + " => " + Std.string(entry.value);
                if(iterator.hasNext()){
                    str += ", ";
                }
            }
        }
        return str + "]";
    }

    // Abstract's functionality below
    
    #if !functional_mutable
    public static function fromIterable<T>(iterable:Iterable<T>):KeyValueCollection<Int, T> {
        return new KeyValueCollection(
            ()->{
                var i = 0;
                for(item in iterable){
                    i++;
                }
                return i;
            },
            ()->{
                var iterator = iterable.iterator();
                var i = 0;
                var kvIterator:KeyValueIterator<Int, T> = {
                    hasNext: iterator.hasNext,
                    next: ()->{
                        key: i++,
                        value: iterator.next()
                    }
                };
                return kvIterator;
            },
            (key)->{
                var i = 0;
                for(item in iterable){
                    if(key == i){
                        return item;
                    }
                    i++;
                }
                return null;
            },
            (key)->{
                var i = -1;
                for(item in iterable){
                    i++;
                }
                return key <= i;
            },
            ()->cast new IntMap<T>()
        );
    }
    public static function fromKeyValueItarable<K, V>(iterable:KeyValueIterable<K, V>):KeyValueCollection<K, V> {
        return new KeyValueCollection(
            ()->{
                var i = 0;
                for(item in iterable.keyValueIterator()){
                    i++;
                }
                return i;
            },
            iterable.keyValueIterator,
            (key)->{
                for(item in iterable.keyValueIterator()){
                    if(key == item.key){
                        return item.value;
                    }
                }
                return null;
            },
            (key)->{
                for(item in iterable.keyValueIterator()){
                    if(key == item.key){
                        return true;
                    }
                }
                return false;
            }
        );
    }
    #end
    public static function fromArray<T>(array:Array<T>):KeyValueCollection<Int, T> {
        return new KeyValueCollection(
            ()->array.length,
            #if flash ()->array.keyValueIterator()
            #else array.keyValueIterator
            #end,
            (key)->array[key],
            (key)->key >= 0 && key < array.length,
            ()->cast new IntMap()
        )#if functional_mutable 
        .setSetFunction((key:Int, val:T)->array[key] = val)
        .setRemoveFunction((key)->array.splice(key, 1))
        #end;
    }
    public static function fromMap<K, V>(map:Map<K, V>):KeyValueCollection<K, V> {
        return new KeyValueCollection(
            ()->{
                var i = 0;
                for(item in map){
                    i++;
                }
                return i;
            },
            map.keyValueIterator,
            map.get,
            map.exists,
            ()->cast emptyMapOfTypeByRuntimeTypeChecks(cast map)
        )#if functional_mutable
        .setSetFunction(map.set)
        .setRemoveFunction(map.remove)
        #end;
    }

    public function toArray():Array<V> {
        final array = [];
        var i = 0;
        for(key => value in this){
            if(key is Int){
                array[cast(key, Int)] = value;
            }
            else array[i++] = value;
        }
        return array;
    }

    public #if !no_functional_inline inline #end function iterator():Iterator<V> {
        final keyValueIterator = this.keyValueIterator();
        return {
            hasNext: keyValueIterator.hasNext,
            next: ()->keyValueIterator.next().value
        };
    }
    
    public #if !no_functional_inline inline #end function map<T>(fn:(key:K, value:V)->T):KeyValueCollection<K, T> {
        final transformed = this.emptyMap();
        for(entry in this.keyValueIterator()){
            transformed.set(entry.key, fn(entry.key, entry.value));
        }
        return fromMap(cast transformed);
    }
    
    public #if !no_functional_inline inline #end function filter(fn:(key:K, value:V)->Bool):KeyValueCollection<K, V> {
        return reject((key, value)->!fn(key, value));
    }

    public #if !no_functional_inline inline #end function first():Null<KeyValuePair<K, V>> {
        return this.keyValueIterator().hasNext()
            ? this.keyValueIterator().next()
            : null;
    }

    public #if !no_functional_inline inline #end function find(fn:(key:K, value:V)->Bool):Null<KeyValuePair<K, V>> {
        #if no_functional_inline
        for(entry in this.keyValueIterator()){
            if(fn(entry.key, entry.value)){
                return entry;
            }
        }
        return null;
        #else
        // This variable is required to allow inlining the function
        var pair = null;
        for(entry in this.keyValueIterator()){
            if(fn(entry.key, entry.value)) {
                pair = entry;
                break;
            }
        }
        return pair;
        #end
    }
    
    public #if !no_functional_inline inline #end function reject(fn:(key:K, value:V)->Bool):KeyValueCollection<K, V> {
        #if functional_mutable
        // this.remove will cause a ConcurrentModificationException
        // Recursion is avoided by reassigning iterator. This should perform better (?)
        var iterator = this.keyValueIterator();
        while(iterator.hasNext()){
            final entry = iterator.next();
            if(fn(entry.key, entry.value)){
                this.remove(entry.key);
                iterator = this.keyValueIterator();
            }
        }
        return cast this;
        #else
        final transformed = this.emptyMap();
        for(entry in this.keyValueIterator()){
            if(!fn(entry.key, entry.value)){
                transformed.set(entry.key, entry.value);
            }
        }
        return fromMap(cast transformed);
        #end
    }
    
    public #if !no_functional_inline inline #end function reduce<T>(startingModifier:T, fn:(modifier:T, key:K, value:V)->T):T {
        for(entry in this.keyValueIterator()){
            startingModifier = fn(startingModifier, entry.key, entry.value);
        }
        return startingModifier;
    }

    public #if !no_functional_inline inline #end function each(fn:(key:K, value:V)->Void):Void {
        for(item in this.keyValueIterator()){
            fn(item.key, item.value);
        }
    }

    public #if !no_functional_inline inline #end function any():Bool {
        return first() != null;
    }

    private static function emptyMapOfTypeByRuntimeTypeChecks<K, V>(pairs:KeyValueIterable<K, V>):Map<K, Any> {
        if(pairs is IntMap){
            return cast new IntMap<Any>();
        }
        else if(pairs is StringMap){
            return cast new StringMap<Any>();
        }
        else if(pairs is ObjectMap){
            return cast new ObjectMap<{}, Any>();
        }
        else return null;
    }
}

typedef KeyValuePair<K, V> = {
    key:K,
    value:V,
}

abstract Pairs<K, V>(KeyValueCollection<K, V>) {

    public var length(get, never):Int;
    
    private #if !no_functional_inline inline #end function new(collection:KeyValueCollection<K, V>){
        this = collection;
    }

    public static inline function empty(){
        return fromArray([]);
    }
    
    #if !functional_mutable
    @:from private static inline function fromIterable<T>(iterable:Iterable<T>):Pairs<Int, T> {
        return new Pairs<Int, T>(KeyValueCollection.fromIterable(iterable));
    }
    @:from private static inline function fromKeyValueItarable<K, V>(iterable:KeyValueIterable<K, V>):Pairs<K, V> {
        return new Pairs<K, V>(KeyValueCollection.fromKeyValueItarable(iterable));
    }
    #end
    @:from private static inline function fromMap<K, V>(map:Map<K, V>):Pairs<K, V> {
        return new Pairs<K, V>(KeyValueCollection.fromMap(map));
    }
    @:from private static inline function fromArray<T>(array:Array<T>):Pairs<Int, T> {
        return new Pairs<Int, T>(KeyValueCollection.fromArray(array));
    }

    @:to private inline function toArray():Array<V> {
        return this.toArray();
    }

    public inline function iterator():Iterator<V> {
        return this.iterator();
    }

    public #if !no_functional_inline inline #end function keyValueIterator():KeyValueIterator<K, V> {
        return this.keyValueIterator();
    }

    @:arrayAccess private #if !no_functional_inline inline #end function at(key:K):Null<V> {
        return this.at(key);
    }

    public #if !no_functional_inline inline #end function exists(key:K):Bool {
        return this.exists(key);
    }

    private #if !no_functional_inline inline #end function get_length():Int {
        return this.length();
    }

    /**
        Creates a new collection modifying each key and value as specified by `fn`.
    **/
    public inline function map<T>(fn:(key:K, value:V)->T):Pairs<K, T> {
        return new Pairs<K, T>(this.map(fn));
    }
    
    #if functional_mutable /**
        Retains only the elements in `this` for which `fn` returned true.
    **/ #else /**
        Creates a new collection containing the elements for which `fn` returned true.
    **/ #end
    public inline function filter(fn:(key:K, value:V)->Bool):Pairs<K, V> {
        return new Pairs<K, V>(this.reject((key, value)->!fn(key, value)));
    }

    /**
        Returns the first element found in `this`'s iterator or null if empty.
    **/
    public inline function first():Null<KeyValuePair<K, V>> {
        return this.first();
    }

    /**
        Returns the first element in `this` for which `fn` returned true or null if none returned true.
    **/
    public inline function find(fn:(key:K, value:V)->Bool):Null<KeyValuePair<K, V>> {
        return this.find(fn);
    }
    
    #if functional_mutable /**
        Removes all elements in `this` for which `fn` returned true.
    **/ #else /**
        Creates a new collection containing the elements for which `fn` returned false.
    **/ #end
    public inline function reject(fn:(key:K, value:V)->Bool):Pairs<K, V> {
        return new Pairs<K, V>(this.reject(fn));
    }
    
    /**
        Returns a modification to `startingModifier` specified by `fn`.
        For each element in `this`, `modifier` of `fn` will be replaced with the previous result of `fn` and start with `startingModifier`. The final result is returned.
    **/
    public inline function reduce<T>(startingModifier:T, fn:(modifier:T, key:K, value:V)->T):T {
        return this.reduce(startingModifier, fn);
    }

    /**
        Executes `fn` for each element in `this`.
    **/
    public inline function each(fn:(key:K, value:V)->Void):Void {
        this.each(fn);
    }

    /**
        Returns whether `this` contains any elements.
    **/
    public inline function any():Bool {
        return this.any();
    }
}

abstract Multitude<T>(KeyValueCollection<Int, T>) {

    public var length(get, never):Int;
    
    private #if !no_functional_inline inline #end function new(collection:KeyValueCollection<Int, T>){
        this = collection;
    }

    public static inline function empty(){
        return fromArray([]);
    }
    
    #if !functional_mutable
    @:from private static inline function fromIterable<T>(iterable:Iterable<T>):Multitude<T> {
        return new Multitude<T>(KeyValueCollection.fromIterable(iterable));
    }
    @:from private static inline function fromKeyValueIterable<T>(iterable:KeyValueIterable<Int, T>):Multitude<T> {
        return new Multitude<T>(KeyValueCollection.fromKeyValueItarable(iterable));
    }
    #end
    @:from private static inline function fromMap<T>(map:Map<Int, T>):Multitude<T> {
        return new Multitude<T>(KeyValueCollection.fromMap(map));
    }
    @:from private static inline function fromArray<T>(array:Array<T>):Multitude<T> {
        return new Multitude<T>(KeyValueCollection.fromArray(array));
    }

    @:to private inline function toArray():Array<T> {
        return this.toArray();
    }

    public inline function iterator():Iterator<T> {
        return this.iterator();
    }

    public #if !no_functional_inline inline #end function keyValueIterator():KeyValueIterator<Int, T> {
        return this.keyValueIterator();
    }

    @:arrayAccess private #if !no_functional_inline inline #end function at(key:Int):Null<T> {
        return this.at(key);
    }

    public #if !no_functional_inline inline #end function exists(key:Int):Bool {
        return this.exists(key);
    }

    private #if !no_functional_inline inline #end function get_length():Int {
        return this.length();
    }

    /**
        Creates a new collection modifying each key and value as specified by `fn`.
    **/
    public inline function map<T2>(fn:(value:T)->T2):Multitude<T2> {
        return cast this.map((key, value)->fn(value));
    }
    
    #if functional_mutable /**
        Retains only the elements in `this` for which `fn` returned true.
    **/ #else /**
        Creates a new collection containing the elements for which `fn` returned true.
    **/ #end
    public inline function filter(fn:(value:T)->Bool):Multitude<T> {
        return cast this.reject((key, value)->!fn(value));
    }

    /**
        Returns the first element found in `this`'s iterator or null if empty.
    **/
    public inline function first():Null<KeyValuePair<Int, T>> {
        return this.first();
    }

    /**
        Returns the first element in `this` for which `fn` returned true or null if none returned true.
    **/
    public inline function find(fn:(value:T)->Bool):Null<KeyValuePair<Int, T>> {
        return this.find((key, value)->fn(value));
    }
    
    #if functional_mutable /**
        Removes all elements in `this` for which `fn` returned true.
    **/ #else /**
        Creates a new collection containing the elements for which `fn` returned false.
    **/ #end
    public inline function reject(fn:(value:T)->Bool):Multitude<T> {
        return cast this.reject((key, value)->fn(value));
    }
    
    /**
        Returns a modification to `startingModifier` specified by `fn`.
        For each element in `this`, `modifier` of `fn` will be replaced with the previous result of `fn` and start with `startingModifier`. The final result is returned.
    **/
    public inline function reduce<T2>(startingModifier:T2, fn:(modifier:T2, value:T)->T2):T2 {
        return this.reduce(startingModifier, (modifier, key, value)->fn(modifier, value));
    }

    /**
        Executes `fn` for each element in `this`.
    **/
    public inline function each(fn:(value:T)->Void):Void {
        this.each((key, value)->fn(value));
    }

    /**
        Returns whether `this` contains any elements.
    **/
    public inline function any():Bool {
        return this.any();
    }
}