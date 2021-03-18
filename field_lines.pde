void settings() {
  System.setProperty("jogl.disable.openglcore", "false");
  size(800, 800, P3D);
  //noLoop();
}

void draw() {
  setup_scene(millis() * 0.01);

  float T = 2000.0;
  float t0 = 0.0;
  float dt = 2;

  // Both of these are consistent with a Python implementation to ~1000 iterations
  //PVector[] V2 = integrate_rk2("lorenz_attractor", t0, T, dt, new PVector(1.0, 0.0, 20.0));
  //PVector[] V4 = integrate_rk4("lorenz_attractor", t0, T, dt, new PVector(1.0, 0.0, 20.0));

  background(0);
  //render(V2);

  for (int j = -15; j <= 15; j+= 15) {
    for (int i = 3; i <= 16; i += 2) {
      render(integrate_rk4("wire_magnetic_field", t0, T, dt, new PVector(wire1P.x - i, wire1P.y, 25 + j)));
      render(integrate_rk4("wire_magnetic_field", t0, T, dt, new PVector(wire2P.x + i, wire2P.y, 25 + j)));
    }
  }

  wire2P.y = 10.0 * sin(millis() * .001);
  wire2P.x = 10.0 + 10.0 * cos(millis() * 0.0004 * PI);

  strokeWeight(0.1);
  stroke(0, 255, 255);
  line(wire1P, PVector.add(wire1P, wire1I));
  line(wire2P, PVector.add(wire2P, wire2I));

  axes();
  bounds(new PVector(40, 60, 50));
}
