export const notZero = (v: number, min = 0) => Math.max(v, min);

export const either = <T>(
    a: boolean,
    b: boolean,
    aNotB: T,
    bNotA: T,
    noneOrBoth: T,
) => (a && !b ? aNotB : b && !a ? bNotA : noneOrBoth);
