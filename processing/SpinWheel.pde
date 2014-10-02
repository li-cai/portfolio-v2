/* @pjs preload="processing/pinwheel.svg"; */

Pinwheel pinwheel;
Stem stem;
ArrayList<Leaf> leaves;

final color bgcolor = #d1e4e8;

float angle = 0;
float increment = -PI/95;

final float MAX_INCREMENT = 0.20;

void setup() {
    size(820, 600);
    background(bgcolor);

    pinwheel = new Pinwheel();
    stem = new Stem();

    leaves = new ArrayList<Leaf>();

    for (int i = 0; i < 50; i++) {
        float leafHeight = random(30, 60);
        float leafX = random(-800, 0);
        float leafY = random(-50, 200);

        Leaf leaf = new Leaf(leafX, leafY, leafHeight);
        leaves.add(leaf);
    }
    
    smooth();

    PVector v1 = new PVector(2,3);
    PVector v2 = new PVector(4,2);
    PVector v3 = v1.add(v2);

    print(v3);
}

void draw() {
    background(bgcolor);

    // draw leaves
    for (int i = 0; i < leaves.size(); i++) {
        pushMatrix();
        Leaf leaf = leaves.get(i);
        leaf.updateVelocity();
        leaf.display();
        popMatrix();
    }

    // draw pinwheel
    pushMatrix();
        translate(width/2, height/2.5);
        stem.display();

        pushMatrix();
            rotate(angle);
            pinwheel.display();
        popMatrix();
    popMatrix();

    angle += increment;
}

void keyPressed() {
    if (keyCode == RIGHT) {
        increment -= PI / 300;

        if (increment < -MAX_INCREMENT) {
            increment = -MAX_INCREMENT;
        }
    }
    else if (keyCode == LEFT) {
        increment += PI / 300;

        if (increment > MAX_INCREMENT) {
            increment = MAX_INCREMENT;
        }
    }
}

class Pinwheel {
    PShape pinwheel;

    Pinwheel() {
        pinwheel = loadShape("processing/pinwheel.svg");
    }

    void display() {
        shapeMode(CENTER);
        shape(pinwheel);
    }
}

class Stem {
    color stemColor = #3d3d3d;

    Stem() {}

    void display() {
        noStroke();
        fill(stemColor);
        rect(-5, 0, 10, height / 1.5);
    }
}

class Leaf {

    float x, y, t;
    float cHeight, angle;

    PVector deltaSum;
    PVector delta;
    PVector velocity;

    float theta = 0;
    float initialX = 3.0;
    float initialY = 1.2;

    color leafColor = #6bd15d;

    Leaf(float x, float y, float cHeight) {
        this.x = x;
        this.y = y;
        this.cHeight = cHeight;
        this.angle = 0;

        float colorCode = random(0, 1);
        if (colorCode < 0.2) {
            leafColor = #e2a0f2;
        }

        deltaSum = new PVector(0, 0);
        delta = new PVector(0, 0);
        velocity = new PVector(2.5, 1.1);

        t = random(0, 20);
    }

    void display() {
        float midX = cHeight * (12.0/60);
        float midY = cHeight * (5.0/9);

        float newX = x + deltaSum.x;
        float newY = y + deltaSum.y;

        if (newX > width && newY > height) {
            deltaSum.x = 0;
            deltaSum.y = 0;
        }

        pushMatrix();
            theta = map(noise(t), 0, 1, -PI/2, PI/8);

            translate(newX, newY);
            rotate(theta);

            beginShape();
            noStroke();
            fill(leafColor, 200);
            curveVertex(0, 0);
            curveVertex(0, 0);
            curveVertex(midX, -midY);
            curveVertex(0, -cHeight);
            curveVertex(-midX, -midY);
            curveVertex(0, 0);
            curveVertex(0, 0);
            endShape();
        popMatrix();

        delta = PVector.fromAngle(-theta);
        delta.x = delta.x * velocity.x;
        delta.y = delta.y * velocity.y;
        deltaSum.add(delta);

        t += 0.003;
    }

    void updateVelocity() {
        float xratio = initialX / (-PI/95);
        float yratio = initialY / (-PI/95);

        velocity.x = -Math.abs(increment) * xratio;
        velocity.y = -Math.abs(increment) * yratio;
    }
}