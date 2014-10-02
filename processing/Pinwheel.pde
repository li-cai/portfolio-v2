class Pinwheel {
    PShape pinwheel;

    Pinwheel() {
        pinwheel = loadShape("pinwheel.svg");
    }

    void display() {
        shapeMode(CENTER);
        shape(pinwheel);
    }
}