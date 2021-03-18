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
  translate(0, 0, 25);
  box(b.x, b.y, b.z);
  popMatrix();
}

void line(PVector a, PVector b) {
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}
