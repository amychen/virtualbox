class Butterfly {
  PVector pos, flightSp;
  float flapSpeed;
  float ang;
  float ang2;
  float xoff = random(0.01, 0.05);

  Butterfly(float x, float y, float z) {
    pos = new PVector(x, y, z);
    flightSp = new PVector(random(1, 5), random(1, 5), random(1, 5));
    flapSpeed = random(0.5, 0.8);
    ang = random(180);
    ang2 = random(360);
  }

  void fly() {
    pushMatrix();
    pos.x = sin(radians(ang2 + noise(xoff))) * width / 8;
    pos.y = cos(radians(ang2)) * 100;
    translate(width/2 + pos.x, height/2 + pos.y, pos.z);
    ang2 += 2;
    xoff += 0.01;
    popMatrix();
  }

  void checkEdge() {
    if (pos.x < cubeWidth/2 + 200) {
      pos.x = lerp(pos.x, -cubeWidth/2, 0.1);
      flightSp.x *= -1;
    } else if (pos.x > cubeWidth/2 - 200) {
      pos.x = lerp(pos.x, cubeWidth/2, 0.1);
      flightSp.x *= -1;
    }
    if (pos.y < -cubeWidth/2 + 200) {
      pos.y = lerp(pos.y, -cubeWidth/2, 0.1);
      flightSp.y *= -1;
    } else if (pos.y > cubeWidth/2 - 200) {
      pos.y = lerp(pos.y, cubeWidth/2, 0.1);
      flightSp.y *= -1;
    }

    if (pos.z < -cubeWidth/2 + 200) {
      pos.z = lerp(pos.z, -cubeWidth/2, 0.1);
      flightSp.z *= -1;
    } else if (pos.z > cubeWidth/2 - 200) {
      pos.z = lerp(pos.z, cubeWidth/2, 0.1);
      flightSp.z *= -1;
    }
  }

  void wingAng() {
    ang += flapSpeed;
    if (ang > 3) {
      ang = 3;
      flapSpeed *= -1;
    }
    else if (ang < -3) {
      ang = -3;
      flapSpeed *= -1;
    }
  }

  void wing(float rad) {
    float r = sin(rad * 2) * 30;
    float x = r * sin(rad);
    float y = r * cos(rad);
    vertex(x, y);
  }

  void flapRight() {
    
    pushMatrix();
    beginShape();
    translate(pos.x, pos.y, pos.z);
    rotateX(-PI/7);
    rotateY(sin(radians(ang)) * -10);
    for (float rad = -PI/2; rad <= PI/2; rad += 0.3) {
      wing(rad);
    }
    endShape();
    popMatrix();
  }

  void flapLeft() {
    pushMatrix();
    beginShape();
    translate(pos.x, pos.y, pos.z);
    rotateX(-PI/7);
    rotateY(sin(radians(ang)) * 10);
    for (float rad = -PI/2; rad >= -3 * PI/2; rad -= 0.3) {
      wing(rad);
    }
    endShape();
    popMatrix();
  }
}
