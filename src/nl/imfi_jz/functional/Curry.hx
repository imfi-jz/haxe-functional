package nl.imfi_jz.functional;

typedef CurriedFunction<T1, T2, R> = (a:T1)->((b:T2)->R);

@:forward(bind)
abstract Curry<T1, T2, R>(CurriedFunction<T1, T2, R>) from CurriedFunction<T1, T2, R> to CurriedFunction<T1, T2, R> {

    @:from private static #if !no_functional_inline inline #end function fromTwo<T1, T2, R>(fn:(a:T1, b:T2)->R):Curry<T1, T2, R> {
        return (a:T1)->((b:T2)->fn(a, b));
    }
    public static #if !no_functional_inline inline #end function two<T1, T2, R>(fn:(a:T1, b:T2)->R):CurriedFunction<T1, T2, R> {
        return fromTwo(fn);
    }

    @:from private static #if !no_functional_inline inline #end function fromThree<T1, T2, T3, R>(fn:(a:T1, b:T2, c:T3)->R):Curry<T1, T2, (c:T3)->R> {
        return (a:T1)->((b:T2)->(c:T3)->fn(a, b, c));
    }
    public static #if !no_functional_inline inline #end function three<T1, T2, T3, R>(fn:(a:T1, b:T2, c:T3)->R):CurriedFunction<T1, T2, (c:T3)->R> {
        return fromThree(fn);
    }

    @:from private static #if !no_functional_inline inline #end function fromFour<T1, T2, T3, T4, R>(fn:(a:T1, b:T2, c:T3, d:T4)->R):Curry<T1, T2, CurriedFunction<T3, T4, R>> {
        return (a:T1)->(((b:T2)->((c:T3)->(d:T4)->fn(a, b, c, d))));
    }
    public static #if !no_functional_inline inline #end function four<T1, T2, T3, T4, R>(fn:(a:T1, b:T2, c:T3, d:T4)->R):CurriedFunction<T1, T2, CurriedFunction<T3, T4, R>> {
        return fromFour(fn);
    }

    @:from private static #if !no_functional_inline inline #end function fromFive<T1, T2, T3, T4, T5, R>(fn:(a:T1, b:T2, c:T3, d:T4, e:T5)->R):Curry<T1, T2, CurriedFunction<T3, T4, (e:T5)->R>> {
        return (a:T1)->((((b:T2)->(((c:T3)->((d:T4)->(e:T5)->fn(a, b, c, d, e)))))));
    }
    public static #if !no_functional_inline inline #end function five<T1, T2, T3, T4, T5, R>(fn:(a:T1, b:T2, c:T3, d:T4, e:T5)->R):CurriedFunction<T1, T2, CurriedFunction<T3, T4, (e:T5)->R>> {
        return fromFive(fn);
    }

    @:from private static #if !no_functional_inline inline #end function fromSix<T1, T2, T3, T4, T5, T6, R>(fn:(a:T1, b:T2, c:T3, d:T4, e:T5, f:T6)->R):Curry<T1, T2, CurriedFunction<T3, T4, CurriedFunction<T5, T6, R>>> {
        return (a:T1)->(((((b:T2)->((((c:T3)->(((d:T4)->((e:T5)->(f:T6)->fn(a, b, c, d, e, f)))))))))));
    }
    public static #if !no_functional_inline inline #end function six<T1, T2, T3, T4, T5, T6, R>(fn:(a:T1, b:T2, c:T3, d:T4, e:T5, f:T6)->R):CurriedFunction<T1, T2, CurriedFunction<T3, T4, CurriedFunction<T5, T6, R>>> {
        return six(fn);
    }

    @:from private static #if !no_functional_inline inline #end function fromSeven<T1, T2, T3, T4, T5, T6, T7, R>(fn:(a:T1, b:T2, c:T3, d:T4, e:T5, f:T6, g:T7)->R):Curry<T1, T2, CurriedFunction<T3, T4, CurriedFunction<T5, T6, (g:T7)->R>>> {
        return (a:T1)->((((((b:T2)->(((((c:T3)->((((d:T4)->(((e:T5)->((f:T6)->(g:T7)->fn(a, b, c, d, e, f, g))))))))))))))));
    }
    public static #if !no_functional_inline inline #end function seven<T1, T2, T3, T4, T5, T6, T7, R>(fn:(a:T1, b:T2, c:T3, d:T4, e:T5, f:T6, g:T7)->R):CurriedFunction<T1, T2, CurriedFunction<T3, T4, CurriedFunction<T5, T6, (g:T7)->R>>> {
        return seven(fn);
    }

    public #if !no_functional_inline inline #end function apply(a:T1):((b:T2)->R) {
        return this(a);
    }
}