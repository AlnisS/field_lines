class Field {
  ArrayList<Monopole> monopoles = new ArrayList<Monopole>();
  
  void addMonopole(Monopole monopole) {
    monopoles.add(monopole);
  }

  Trace trace(PVector seed, Class type) {
    PVector[] points = integrate_rk4(type, 0.1, 10000, seed);
    float[] strengths = new float[points.length];
    for (int i = 0; i < points.length; i++)
      strengths[i] = potential(type, points[i]);
    return new Trace(points, strengths);
  }

  PVector influence(Class type, PVector point) {
    PVector result = new PVector();
    for (Monopole monopole : monopoles) {
      if (type.isInstance(monopole)) {
        result.add(monopole.influence(point));
      }
    }
    return result;
  }
  
  float potential(Class type, PVector point) {
    float result = 0;
    for (Monopole monopole : monopoles) {
      if (type.isInstance(monopole)) {
        result += monopole.potential(point);
      }
    }
    return result;
  }

  PVector[] integrate_rk4(Class type, float dt, int steps, PVector v0) {
    PVector[] V = new PVector[steps];
    V[0] = v0;
    float firstStepMag = -1;

    for (int k = 0; k < V.length - 1; k++) {
      PVector f1 = influence(type, V[k]);
      PVector f2 = influence(type, PVector.add(V[k], PVector.mult(f1, dt / 2)));
      PVector f3 = influence(type, PVector.add(V[k], PVector.mult(f2, dt / 2)));
      PVector f4 = influence(type, PVector.add(V[k], PVector.mult(f3, dt)));
      // Note: vectors are processed destructively for this last operation
      PVector temp = f1.add(f2.mult(2)).add(f3.mult(2)).add(f4).mult(dt / 6);
      //if (norm)
      //  temp.normalize();
        //temp.setMag(0.1);
      V[k + 1] = PVector.add(V[k], temp);

      PVector thisStep = PVector.sub(V[k + 1], V[0]);
      float thisStepMag = thisStep.mag() / dt;

      // We'll use the size of the first step as a heuristic for when we've completed a loop
      //if (firstStepMag == -1)
      //  firstStepMag = thisStepMag;

      // If we've completed a loop, we can quit early (i.e. for magnetism)
      // or if we are in a very negative place (i.e. near negative pole of charge)
      if (potential(type, V[k + 1]) < -1) { //  || influence(type, V[k + 1])
        PVector[] newV = new PVector[k + 2];
        System.arraycopy(V, 0, newV, 0, k + 2);
        V = newV;
        break;
      }
      
      //println(100 / thisStepMag);
      //dt = 5 / max(thisStepMag, 0);
      //maxMag = max(dt, maxMag);
      //println(maxMag);
      //if (norm)
        dt = min(10, 0.5 / pow(abs(potential(type, V[k + 1])), 0.5));
      
      //dt = thisStepMag;
      //print(dt);
    }

    return V;
  }
}

float maxMag = 0;

boolean norm = false;

class Electric extends Monopole {
  Electric(PVector position, float strength) {
    super(position, strength);
  }

  float magnitude(float displacement) {
    return 1 / pow(displacement, 2);
  }
}

abstract class Monopole {
  PVector position;
  float strength;

  Monopole(PVector position, float strength) {
    this.position = position;
    this.strength = strength;
  }

  PVector influence(PVector location) {
    PVector displacement = PVector.sub(location, position);
    displacement.setMag(strength * magnitude(displacement.mag()));
    return displacement;
  }
  
  float potential(PVector location) {
    PVector displacement = PVector.sub(location, position);
    return strength * magnitude(displacement.mag());
  }

  abstract float magnitude(float displacement);
}

class Trace {
  PVector[] points;
  float[] strengths;
  float minStrength, maxStrength;
  color
    minColor = color(0, 0, 255), 
    maxColor = color(255, 0, 0);

  Trace(PVector[] points, float[] strengths) {
    this.points = points;
    this.strengths = strengths;
    this.minStrength = min(strengths);
    this.maxStrength = max(strengths);
  }

  void render(float strokeWeight) {
    strokeWeight(strokeWeight);
    for (int k = 0; k < points.length - 1; k++) {
      stroke(lerpColor(minColor, maxColor, norm(strengths[k], minStrength, maxStrength)));
      line(points[k], points[k + 1]);
    }
  }
}
