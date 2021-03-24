void settings() {
  System.setProperty("jogl.disable.openglcore", "false");
  size(800, 800, P3D);
  //noLoop();
}

Field field;

void setup() {
  field = new Field();
  field.addMonopole(new Electric(new PVector(0, 0, 5), -5));
  field.addMonopole(new Electric(new PVector(0, 0, 5), -5));
  field.addMonopole(new Electric(new PVector(0, 0, 25), 10));
}

void draw() {
  
  
  setup_scene(millis() * 0.01);
  
  scale(1, 1, -1);
  lights();
  scale(1, 1, -1);
  
  float T = 2000.0;
  float t0 = 0.0;
  float dt = 2;

  // Both of these are consistent with a Python implementation to ~1000 iterations
  //PVector[] V2 = integrate_rk2("lorenz_attractor", t0, T, dt, new PVector(1.0, 0.0, 20.0));
  //PVector[] V4 = integrate_rk4("lorenz_attractor", t0, T, dt, new PVector(1.0, 0.0, 20.0));

  background(0);
  //render(V2);

  //PVector[] tmp = null;
  
  field.monopoles.get(0).position.z = 25 + 15 * sin(millis() * 0.001);
  field.monopoles.get(0).position.x = 0 + 10 * cos(millis() * 0.001);
  field.monopoles.get(0).position.y = 5;
  
  field.monopoles.get(1).position.z = 25 + 30 * sin(millis() * -0.001);
  field.monopoles.get(1).position.x = 0 + 20 * cos(millis() * -0.001);
  field.monopoles.get(1).position.y = -5;
  
  float traceOffset = 2;
  
  norm = false;
  
  field.trace(new PVector(traceOffset, 0, 25), Electric.class).render(0.1);
  field.trace(new PVector(0, traceOffset, 25), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, 0, 25), Electric.class).render(0.1);
  field.trace(new PVector(0, -traceOffset, 25), Electric.class).render(0.1);
  
  field.trace(new PVector(traceOffset, 0, 25 + traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(0, traceOffset, 25 + traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, 0, 25 + traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(0, -traceOffset, 25 + traceOffset), Electric.class).render(0.1);
  
  field.trace(new PVector(traceOffset, 0, 25 - traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(0, traceOffset, 25 - traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, 0, 25 - traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(0, -traceOffset, 25 - traceOffset), Electric.class).render(0.1);
  
  
  
  
  field.trace(new PVector(traceOffset, traceOffset, 25), Electric.class).render(0.1);
  field.trace(new PVector(traceOffset, -traceOffset, 25), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, -traceOffset, 25), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, traceOffset, 25), Electric.class).render(0.1);
  
  field.trace(new PVector(traceOffset, traceOffset, 25 + traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(traceOffset, -traceOffset, 25 + traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, -traceOffset, 25 + traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, traceOffset, 25 + traceOffset), Electric.class).render(0.1);
  
  field.trace(new PVector(traceOffset, traceOffset, 25 - traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(traceOffset, -traceOffset, 25 - traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, -traceOffset, 25 - traceOffset), Electric.class).render(0.1);
  field.trace(new PVector(-traceOffset, traceOffset, 25 - traceOffset), Electric.class).render(0.1);
  
  noStroke();
  pushMatrix();
  PVector temp = field.monopoles.get(0).position;
  translate(temp.x, temp.y, temp.z);
  fill(color(0, 0, 255));
  sphere(sqrt(5));
  popMatrix();
  
  pushMatrix();
  temp = field.monopoles.get(1).position;
  translate(temp.x, temp.y, temp.z);
  fill(color(0, 0, 255));
  sphere(sqrt(5));
  popMatrix();
  
  pushMatrix();
  temp = field.monopoles.get(2).position;
  translate(temp.x, temp.y, temp.z);
  fill(color(255, 0, 0));
  sphere(5);
  popMatrix();

  //for (int j = -15; j <= 15; j+= 15) {
  //  for (int i = 3; i <= 16; i += 2) {
  //    render(tmp = integrate_rk4("wire_magnetic_field", t0, T, dt, new PVector(wire1P.x - i, wire1P.y, 25 + j)), wire_magnetic_field_color(tmp));
  //    render(tmp = integrate_rk4("wire_magnetic_field", t0, T, dt, new PVector(wire2P.x + i, wire2P.y, 25 + j)), wire_magnetic_field_color(tmp));
  //  }
  //}

  //wire2P.y = 10.0 * sin(millis() * .001);
  //wire2P.x = 10.0 + 10.0 * cos(millis() * 0.0004 * PI);

  //strokeWeight(0.1);
  //stroke(0, 255, 255);
  //line(wire1P, PVector.add(wire1P, wire1I));
  //line(wire2P, PVector.add(wire2P, wire2I));

  axes();
  bounds(new PVector(40, 60, 50));
}
