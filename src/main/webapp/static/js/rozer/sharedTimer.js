const sharedTimer = {
  timeLeft: 6,
  intervalId: null,

  startTimer() {
      this.intervalId = setInterval(() => {
          this.timeLeft--;
          this.updateTimeDisplay();
          this.logTimeRemaining();

          if (this.timeLeft === 0) {
              this.stopTimer();
              this.redirectToDeadInDark();
          }
      }, 1000);
  },

  stopTimer() {
      clearInterval(this.intervalId);
  },

  updateTimeDisplay() {
      const timeLeftDisplay = document.querySelector('.time-left');
      timeLeftDisplay.textContent = `Time left: ${this.timeLeft} seconds`;
  },

  logTimeRemaining() {
      console.log(`Time remaining: ${this.timeLeft} seconds`);
  },

  redirectToDeadInDark() {
      window.location.href = '../floor1/Dead_In_Dark2.html';
  }
};

console.log("Starting timer...");
sharedTimer.startTimer();
