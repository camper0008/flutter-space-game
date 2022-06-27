class Vector2d {
  double x, y;

  Vector2d(this.x, this.y);

  operator +(Vector2d v) => Vector2d(x + v.x, y + v.y);
  operator -(Vector2d v) => Vector2d(x - v.x, y - v.y);
  operator *(Vector2d v) => Vector2d(x * v.x, y * v.y);

  Vector2d copy() => Vector2d(x, y);
  Vector2d addN(double n) {
    x += n;
    y += n;
    return this;
  }

  Vector2d subtractN(double n) {
    x -= n;
    y -= n;
    return this;
  }

  Vector2d multiplyN(double n) {
    x *= n;
    y *= n;
    return this;
  }

  Vector2d divideN(double n) {
    if (n == 0) throw Exception("cannot divide by zero");
    x /= n;
    y /= n;
    return this;
  }
}
