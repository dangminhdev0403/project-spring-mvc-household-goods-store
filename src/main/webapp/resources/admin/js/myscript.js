function formatNumber(num) {
    if (typeof num !== "number" || isNaN(num)) {
      return "0,00";
    }
  
    const formatter = new Intl.NumberFormat("pt-BR", {
      minimumFractionDigits: 0,
      maximumFractionDigits: 3,
    });
  
    let formattedNumber = formatter.format(num);
    let [integerPart, decimalPart] = formattedNumber.split(",");
  
    if (!decimalPart || decimalPart === "000") {
      return integerPart + " đ";
    }
  
    return `${integerPart},${decimalPart} đ`;
  }
  
  function formatPrice(price) {
    return formatNumber(price);
  }
  
  // Sử dụng hàm formatPrice trong mã của bạn
  const formatPriceElements = document.querySelectorAll(".format-price");
  formatPriceElements.forEach((priceElement) => {
    let numberPrice = parseFloat(priceElement.textContent);
    priceElement.textContent = formatPrice(numberPrice);
  });
  