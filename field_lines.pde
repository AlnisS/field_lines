void settings() {
  System.setProperty("jogl.disable.openglcore", "false");
  size(800, 800, P3D);
  //noLoop();
}

void draw() {
  setup_scene(millis() * 0.05);

  //float T = 50;
  float t0 = 0.0;
  float T = millis() * .001;
  float dt = 0.01;

  // Both of these are consistent with a Python implementation to ~1000 iterations
  PVector[] V2 = integrate_rk2("lorenz_attractor", t0, T, dt, new PVector(1.0, 0.0, 20.0));
  PVector[] V4 = integrate_rk4("lorenz_attractor", t0, T, dt, new PVector(1.0, 0.0, 20.0));

  background(0);
  render(V2);
  render(V4);
  axes();
  bounds(new PVector(40, 60, 50));
}
