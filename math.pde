PVector v0 = new PVector(1.0, 0.0, 20.0);



PVector f(float t, PVector v) {
  PVector result = new PVector();

  result.x = 10.0 * (v.y - v.x);
  result.y = v.x * (28.0 - v.z) - v.y;
  result.z = v.x * v.y - (8.0 / 3.0) * v.z;

  return result;
}

PVector[] integrate_rk2(float T, float dt) {
  float[] t = new float[(int) (T / dt)];
  int n = t.length;
  for (int i = 0; i < n; i++)
    t[i] = dt * i;

  PVector[] V = new PVector[n];

  V[0] = v0;

  for (int k = 0; k < n - 1; k++) {
    V[k + 1] = f(t[k], V[k]).mult(dt).add(V[k]);
  }
  
  return V;
}
