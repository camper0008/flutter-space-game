export class Vector2d {
    public constructor(public x: number, public y: number) {}

    public copy(): Vector2d {
        return new Vector2d(this.x, this.y);
    }

    public add({ x, y }: Vector2d): Vector2d {
        this.x += x;
        this.y += y;
        return this;
    }

    public subract({ x, y }: Vector2d): Vector2d {
        this.x -= x;
        this.y -= y;
        return this;
    }

    public multiply({ x, y }: Vector2d): Vector2d {
        this.x *= x;
        this.y *= y;
        return this;
    }

    public addN(v: number): Vector2d {
        this.x += v;
        this.y += v;
        return this;
    }

    public subractN(v: number): Vector2d {
        this.x -= v;
        this.y -= v;
        return this;
    }

    public multiplyN(v: number): Vector2d {
        this.x *= v;
        this.y *= v;
        return this;
    }

    public divideN(v: number): Vector2d {
        if (v === 0) throw new Error("cannot divide by zero");
        this.x /= v;
        this.y /= v;
        return this;
    }
}

export const vec2d = (x = 0, y = x) => new Vector2d(x, y);
