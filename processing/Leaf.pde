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