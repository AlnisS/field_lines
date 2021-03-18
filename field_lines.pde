void settings() {
  System.setProperty("jogl.disable.openglcore", "false");
  size(800, 800, P3D);
}

void draw() {
  setup_scene(millis() * 0.05);

  //float T = 50;
  float T = millis() * .001;
  float dt = 0.01;
  
  PVector[] V = integrate_rk2(T, dt);

  println(V[V.length - 1]);

  background(0);
  render(V);
  axes();
  bounds(new PVector(40, 60, 50));
}
