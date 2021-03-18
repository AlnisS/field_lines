PVector lorenz_attractor(float t, PVector v) {
  PVector result = new PVector();

  result.x = 10.0 * (v.y - v.x);
  result.y = v.x * (28.0 - v.z) - v.y;
  result.z = v.x * v.y - (8.0 / 3.0) * v.z;

  return result;
}
