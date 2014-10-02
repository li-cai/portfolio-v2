class Stem {
    color stemColor = #3d3d3d;

    Stem() {}

    void display() {
        noStroke();
        fill(stemColor);
        rect(-5, 0, 10, height / 1.5);
    }
}