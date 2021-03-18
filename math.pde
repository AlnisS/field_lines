PVector[] integrate_rk2(String name, float t0, float T, float dt, PVector v0) {
  DiffEq de = new DiffEq(name);
  float[] t = arange(t0, T, dt);
  PVector[] V = new PVector[t.length];
  V[0] = v0;

  for (int k = 0; k < V.length - 1; k++) {
    PVector f1 = de.f(t[k], V[k]);
    // Note: vectors are processed destructively for this last operation
    V[k + 1] = PVector.add(V[k], de.f(t[k] + dt / 2, f1.mult(dt / 2).add(V[k])).mult(dt));
  }

  return V;
}

PVector[] integrate_rk4(String name, float t0, float T, float dt, PVector v0) {
  DiffEq de = new DiffEq(name);
  float[] t = arange(t0, T, dt);
  PVector[] V = new PVector[t.length];
  V[0] = v0;

  for (int k = 0; k < V.length - 1; k++) {
    PVector f1 = de.f(t[k], V[k]);
    PVector f2 = de.f(t[k] + dt / 2, PVector.add(V[k], PVector.mult(f1, dt / 2)));
    PVector f3 = de.f(t[k] + dt / 2, PVector.add(V[k], PVector.mult(f2, dt / 2)));
    PVector f4 = de.f(t[k] + dt, PVector.add(V[k], PVector.mult(f3, dt)));
    // Note: vectors are processed destructively for this last operation
    V[k + 1] = PVector.add(V[k], f1.add(f2.mult(2)).add(f3.mult(2)).add(f4).mult(dt / 6));

    // If we've completed a loop, we can quit early
    if (PVector.sub(V[k + 1], V[0]).mag() < 0.3 && k > 10) {
      PVector[] newV = new PVector[k + 2];
      System.arraycopy(V, 0, newV, 0, k + 2);
      V = newV;
      break;
    }
  }

  return V;
}
