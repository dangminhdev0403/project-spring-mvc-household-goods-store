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
document.addEventListener("DOMContentLoaded", function () {
  const formatDate = document.querySelectorAll(".format-date");

  // Đảm bảo rằng locale tiếng Việt đã được tải và sử dụng
  moment.locale("vi"); // Đặt locale toàn cục là tiếng Việt

  formatDate.forEach((dateElement) => {
    let textDate = dateElement.textContent.trim(); // Lấy nội dung văn bản
    console.log("Trước khi xử lý:", textDate);

    // Nếu chuỗi có phân số giây, cắt bỏ dư thừa
    if (textDate.includes(".")) {
      textDate = textDate.replace(/\.\d+$/, ""); // Loại bỏ phân số giây dư thừa
    }

    // Định dạng ngày giờ theo múi giờ UTC và chuyển đổi sang giờ Việt Nam
    const formattedDate = moment(textDate) // Đảm bảo thời gian là UTC
      .local() // Chuyển đổi từ UTC sang múi giờ địa phương (GMT+7 - Việt Nam)
      .format("HH:mm DD/MM/YYYY"); // Định dạng giờ và ngày theo định dạng Việt Nam

    // Cập nhật nội dung văn bản
    dateElement.textContent = formattedDate;
  });
});
