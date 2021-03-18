PVector lorenz_attractor(float t, PVector v) {
  PVector result = new PVector();

  result.x = 10.0 * (v.y - v.x);
  result.y = v.x * (28.0 - v.z) - v.y;
  result.z = v.x * v.y - (8.0 / 3.0) * v.z;

  return result;
}

PVector wire1I = new PVector(0, 0, 40);
PVector wire1P = new PVector(-10, 0, 5);

PVector wire2I = new PVector(0, 0, 40);
PVector wire2P = new PVector(10, 0, 5);

//PVector wire2I = new PVector(0, 0, -40);
//PVector wire2P = new PVector(10, 0, 45);

PVector wire_magnetic_field(float t, PVector v) {
  PVector wire1O = PVector.sub(v, wire1P);
  PVector wire1B = wire1I.copy().cross(wire1O).normalize().div(min_dist(wire1P, wire1I, v));

  PVector wire2O = PVector.sub(v, wire2P);
  PVector wire2B = wire2I.copy().cross(wire2O).normalize().div(min_dist(wire2P, wire2I, v));

  return PVector.add(wire1B, wire2B);
}
