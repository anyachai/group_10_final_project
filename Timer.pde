class Timer {
  int interval;
  int lastTriggerTime;
  boolean active;
  boolean paused;

  Timer(int interval) {
    this.interval = interval;
    this.lastTriggerTime = 0;
    this.active = false;
    this.paused = false;
  }

  void start() {
    lastTriggerTime = millis();
    active = true;
  }

  boolean update() {
    if (active && !paused && millis() - lastTriggerTime >= interval) {
      lastTriggerTime = millis();
      return true;
    }
    return false;
  }

  void pause() {
    paused = true;
  }

  void resume() {
    paused = false;
  }

  boolean isPaused() {
    return paused;
  }
}
