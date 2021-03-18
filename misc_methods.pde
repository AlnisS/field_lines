void setup_scene(float zrot) {
  translate(width / 2, height / 2);
  scale(-10, 10, 10);

  translate(0.0, 25.0, -30.0);
  rotateX(PI/2);
  rotateZ(radians(150 + zrot));
}

void render(PVector[] V) {
  stroke(255);
  strokeWeight(0.1);
  for (int k = 0; k < V.length - 2; k++)
    line(V[k], V[k+1]);
  stroke(255, 0, 0);
  strokeWeight(0.4);
  line(V[V.length - 2], V[V.length - 1]);
}

void axes() {
  strokeWeight(0.1);
  stroke(255, 0, 0);
  line(0, 0, 0, 10, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 10, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 10);
}

void bounds(PVector b) {
  strokeWeight(0.1);
  stroke(127);
  noFill();
  pushMatrix();
  translate(0, 0, b.z / 2);
  box(b.x, b.y, b.z);
  popMatrix();
}

void line(PVector a, PVector b) {
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}


float[] arange(float t0, float T, float dt) {
  float[] t = new float[(int) ((T - t0 + dt) / dt)];
  int n = t.length;
  for (int i = 0; i < n; i++)
    t[i] = t0 + dt * i;
  return t;
}
