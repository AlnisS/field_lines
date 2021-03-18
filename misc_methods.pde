void setup_scene(float zrot) {
  translate(width / 2, height / 2);
  scale(-10, 10, 10);

  translate(0.0, 25.0, -30.0);
  rotateX(radians(70));
  rotateZ(radians(150 + zrot));
}

void render(PVector[] V, color[] c) {
  stroke(255);
  strokeWeight(0.1);
  for (int k = 0; k < V.length - 2; k++) {
    stroke(c[k]);
    line(V[k], V[k + 1]);
  }
  stroke(255, 0, 0);
  strokeWeight(0.4);
  line(V[V.length - 2], V[V.length - 1]);
}

void axes() {
  strokeWeight(0.1);
  stroke(255, 0, 0);
  line(0, 0, 0, 5, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 5, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 5);
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

float min_dist(PVector a, PVector n, PVector p) {
  return PVector.sub(a, p).cross(n).mag() / n.mag();
}

Object theSuper = this;

class DiffEq {
  java.lang.reflect.Method method;

  DiffEq(String name) {
    try {
      method = theSuper.getClass().getMethod(name, float.class, PVector.class);
    }
    catch (NoSuchMethodException e) {
      println("Warning! No such differential equation method declared: " + name + "(float, PVector)");
      println("Calls to DiffEq.f(float, PVector) will return null.\n");
      println("Declared methods:");
      java.lang.reflect.Method[] methods = theSuper.getClass().getDeclaredMethods();
      for (int i = 0; i < methods.length; i++)
        println(methods[i]);
      println();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  PVector f(float t, PVector v) {
    try {
      if (method != null)
        return (PVector) method.invoke(theSuper, t, v);

      println("Warning: DiffEq.f(float, PVector) called for null method. Returning null PVector.");
      println("Does the method exist with correct parameters in the form name(float, PVector)?");
      println();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}
