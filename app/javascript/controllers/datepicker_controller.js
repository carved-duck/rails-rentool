import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["dailyPrice"]

  connect() {
    flatpickr(this.element, {
      mode: "range",
      dateFormat: "Y-m-d",
      onChange: this.handleDateChange.bind(this)
    })
  }
    handleDateChange(selectedDates) {

    const calculatedPriceDisplay = document.getElementById('calculated-price-display');

    if (selectedDates.length === 2) {
      const startDate = selectedDates[0];
      const endDate = selectedDates[1];
      const priceElement = document.querySelector('h2[data-daily-price]');
      const priceAsString = priceElement.dataset.dailyPrice;
      const priceAsNumber = parseFloat(priceAsString);

      const oneDay = 24 * 60 * 60 * 1000; // milliseconds in one day
      const diffDays = Math.round(Math.abs((startDate.getTime() - endDate.getTime()) / oneDay)) + 1;
      if (diffDays > 0) {
        const totalPrice = diffDays * priceAsNumber;
        console.log(totalPrice)
        console.log(`Selected range: ${diffDays} days. Total price: ¥${totalPrice.toFixed(2)}`);
        calculatedPriceDisplay.textContent = `¥${totalPrice.toFixed(2)}`;
      }
    } else if (selectedDates.length === 1) {
      // User has selected only the start date, or cleared the end date
      console.log("Only one date selected (start date):", selectedDates[0]);
    } else {
      // No dates selected (e.g., cleared the input)
      console.log("No dates selected or selection cleared.");
      // Disable reserve button or reset any dependent UI
    }
  }
}
