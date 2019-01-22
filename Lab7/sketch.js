let population = [];

let food = [];

let debug;

let speedSlider;
let speedSpan;

let foodRadius = 8;
let foodAmount = 25;
let foodBuffer = 50;


let totalSensors = 8;
let sensorLength = 150;
let sensorAngle = (Math.PI * 2) / totalSensors;

let best = null;

function setup() {

  let canvas = createCanvas(640, 360);
  canvas.parent('canvascontainer');
  debug = select('#debug');
  speedSlider = select('#speedSlider');
  speedSpan = select('#speed');

  for (let i = 0; i < 20; i++) {
    population[i] = new Vehicle();
  }
}

function draw() {
  background(0);

  let cycles = speedSlider.value();
  speedSpan.html(cycles);
  for (let n = 0; n < cycles; n++) {
    while (food.length < foodAmount) {
      food.push(createVector(random(foodBuffer, width - foodBuffer), random(foodBuffer, height - foodBuffer)));
    }

    for (let v of population) {
      v.eat(food);
    }

    let record = -1;
    for (let i = population.length - 1; i >= 0; i--) {
      let v = population[i];
      v.think(food);
      v.update(food);

      if (v.dead()) {
        population.splice(i, 1);
      } else {
        if (v.score > record) {
          record = v.score;
          best = v;
        }
      }
    }
    if (population.length < 20) {
      for (let v of population) {
        let newVehicle = v.clone(0.1 * v.score / record);
        if (newVehicle != null) {
          population.push(newVehicle);
        }
      }
    }
  }

  for (let i = 0; i < food.length; i++) {
    fill(100, 255, 100, 200);
    stroke(100, 255, 100);
    ellipse(food[i].x, food[i].y, foodRadius * 2);
  }

  if (debug.checked()) {
    best.highlight();
  }

  for (let v of population) {
    v.display();
  }
}
