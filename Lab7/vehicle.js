function mutate(x) {
  if (random(1) < 0.1) {
    let offset = randomGaussian() * 0.5;
    let newx = x + offset;
    return newx;
  } else {
    return x;
  }
}
class Sensor {
  constructor(angle) {
    this.dir = p5.Vector.fromAngle(angle);
    this.val = 0;
  }
}

class Vehicle {
  constructor(brain) {

    this.acceleration = createVector();
    this.velocity = createVector();
    this.position = createVector(random(width), random(height));
    this.r = 4;
    this.maxforce = 0.1;
    this.maxspeed = 4;
    this.minspeed = 0.25;
    this.maxhealth = 3;

    this.score = 0;

    this.sensors = [];
    for (let angle = 0; angle < TWO_PI; angle += sensorAngle) {
      this.sensors.push(new Sensor(angle));
    }
    if (brain) {
      this.brain = brain.copy();
      this.brain.mutate(mutate);
    } else {
      let inputs = this.sensors.length + 6;
      this.brain = new NeuralNetwork(inputs, 32, 2);
    }

    this.health = 1;
  }

  update() {
    this.velocity.add(this.acceleration);
    this.velocity.limit(this.maxspeed);
    if (this.velocity.mag() < this.minspeed) {
      this.velocity.setMag(this.minspeed);
    }
    this.position.add(this.velocity);
    this.acceleration.mult(0);

    this.health = constrain(this.health, 0, this.maxhealth);
    this.health -= 0.005;
    this.score += 1;
  }
  dead() {
    return (this.health < 0 ||
      this.position.x > width + this.r ||
      this.position.x < -this.r ||
      this.position.y > height + this.r ||
      this.position.y < -this.r
    );
  }
  clone(prob) {
    let r = random(1);
    if (r < prob) {
      return new Vehicle(this.brain);
    }
  }

  think(food) {
    for (let j = 0; j < this.sensors.length; j++) {
      this.sensors[j].val = sensorLength;
    }

    for (let i = 0; i < food.length; i++) {
      let otherPosition = food[i];
      let dist = p5.Vector.dist(this.position, otherPosition);
      if (dist > sensorLength) {
        continue;
      }
      let toFood = p5.Vector.sub(otherPosition, this.position);

      for (let j = 0; j < this.sensors.length; j++) {
        let delta = this.sensors[j].dir.angleBetween(toFood);
        if (delta < sensorAngle / 2) {
          this.sensors[j].val = min(this.sensors[j].val, dist);
        }
      }
    }

    let inputs = [];
    inputs[0] = constrain(map(this.position.x, foodBuffer, 0, 0, 1), 0, 1);
    inputs[1] = constrain(map(this.position.y, foodBuffer, 0, 0, 1), 0, 1);
    inputs[2] = constrain(map(this.position.x, width - foodBuffer, width, 0, 1), 0, 1);
    inputs[3] = constrain(map(this.position.y, height - foodBuffer, height, 0, 1), 0, 1);
    inputs[4] = this.velocity.x / this.maxspeed;
    inputs[5] = this.velocity.y / this.maxspeed;
    for (let j = 0; j < this.sensors.length; j++) {
      inputs[j + 6] = map(this.sensors[j].val, 0, sensorLength, 1, 0);
    }

    let outputs = this.brain.predict(inputs);
    let desired = createVector(2 * outputs[0] - 1, 2 * outputs[1] - 1);
    desired.mult(this.maxspeed);
    let steer = p5.Vector.sub(desired, this.velocity);
    steer.limit(this.maxforce);
    this.applyForce(steer);
  }

  eat(list) {
    for (let i = list.length - 1; i >= 0; i--) {
      let d = p5.Vector.dist(list[i], this.position);
      if (d < foodRadius) {
        list.splice(i, 1);
        this.health++;
      }
    }
  }

  applyForce(force) {
    this.acceleration.add(force);
  }

  display() {
    let green = color(0, 255, 255, 255);
    let red = color(255, 0, 100, 100);
    let col = lerpColor(red, green, this.health)

    push();
    translate(this.position.x, this.position.y);

    if (debug.checked()) {
      for (let i = 0; i < this.sensors.length; i++) {
        let val = this.sensors[i].val;
        if (val > 0) {
          stroke(col);
          strokeWeight(map(val, 0, sensorLength, 4, 0));
          let position = this.sensors[i].dir;
          line(0, 0, position.x * val, position.y * val);
        }
      }
      noStroke();
      fill(255, 200);
      text(int(this.score), 10, 0);
    }
    let theta = this.velocity.heading() + PI / 2;
    rotate(theta);
    fill(col);
    strokeWeight(1);
    stroke(col);
    beginShape();
    vertex(0, -this.r * 2);
    vertex(-this.r, this.r * 2);
    vertex(this.r, this.r * 2);
    endShape(CLOSE);
    pop();
  }

  highlight() {
    fill(255, 255, 255, 50);
    stroke(255);
    ellipse(this.position.x, this.position.y, 32, 32);
  }
}