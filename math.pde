float transfer_t;
PVector transfer_v;
PVector transfer_r;

PVector v0 = new PVector(1.0, 0.0, 20.0);

PVector f(String name, float t, PVector v) {
  // This is a little bit bit hacky, but it's hopefully only a temporary solution
  transfer_t = t;
  transfer_v = v;
  method(name);
  return transfer_r;
}

PVector[] integrate_rk2(String name, float T, float dt) {
  float[] t = arange(0, T, dt);
  PVector[] V = new PVector[t.length];

  V[0] = v0;

  for (int k = 0; k < V.length - 1; k++) {
    PVector f1 = f(name, t[k], V[k]);
    // Note: vectors are processed destructively for this last operation
    V[k + 1] = PVector.add(V[k], f(name, t[k] + dt / 2, f1.mult(dt / 2).add(V[k])).mult(dt));
    // Non-destructive version:
    //V[k + 1] = PVector.add(V[k], PVector.mult(f(name, t[k] + dt / 2, PVector.add(V[k], PVector.mult(f1, dt / 2))), dt));
  }
  
  return V;
}

PVector[] integrate_rk4(String name, float T, float dt) {
  float[] t = arange(0, T, dt);
  PVector[] V = new PVector[t.length];
  
  V[0] = v0;
  
  for (int k = 0; k < V.length - 1; k++) {
    PVector f1 = f(name, t[k], V[k]);
    PVector f2 = f(name, t[k] + dt / 2, PVector.add(V[k], PVector.mult(f1, dt / 2)));
    PVector f3 = f(name, t[k] + dt / 2, PVector.add(V[k], PVector.mult(f2, dt / 2)));
    PVector f4 = f(name, t[k] + dt, PVector.add(V[k], PVector.mult(f3, dt)));
    // Note: vectors are processed destructively for this last operation
    V[k + 1] = PVector.add(V[k], f1.add(f2.mult(2)).add(f3.mult(2)).add(f4).mult(dt / 6));
  }
  
  return V;
}
