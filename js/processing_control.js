var processingInstance;

function startSketch() {
    switchSketchState(true);
}

function stopSketch() {
    switchSketchState(false);
}

function switchSketchState(on) {
    if (!processingInstance) {
        processingInstance = Processing.getInstanceById('pinwheel');
    }

    if (on) {
        processingInstance.loop();
    }
    else {
        processingInstance.noLoop();
    }
}