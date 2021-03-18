void settings() {
  System.setProperty("jogl.disable.openglcore", "false");
  size(800, 800, P3D);
  //noLoop();
}

void draw() {
  setup_scene(millis() * 0.05);

  //float T = 50;
  float T = millis() * .001;
  float dt = 0.01;
  
  // Both of these are consistent with a Python implementation to ~1000 iterations
  PVector[] V2 = integrate_rk2("lorenz_attractor", T, dt);
  PVector[] V4 = integrate_rk4("lorenz_attractor", T, dt);
  
  background(0);
  render(V2);
  render(V4);
  axes();
  bounds(new PVector(40, 60, 50));
}
