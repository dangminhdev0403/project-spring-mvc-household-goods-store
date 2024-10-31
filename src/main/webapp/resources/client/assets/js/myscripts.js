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

function removeDotsAndLetters(input) {
  return input.replace(/[^0-9]/g, "");
}

function totalPrice(quantity, price) {
  return parseFloat(quantity) * parseFloat(price);
}

const formatPrice = document.querySelectorAll(".format-price");
formatPrice.forEach((price) => {
  let numberprice = parseFloat(price.textContent);

  price.textContent = formatNumber(numberprice);
});
let cartItems = document.querySelectorAll(".cart-item__input.quantity");
const printTotals = document.querySelectorAll(".sumPrice"); // Selector cho tổng giá giỏ hàng

cartItems.forEach((cartItem) => {
  const minusBtn = cartItem.querySelector(".minus-btn");
  const plusBtn = cartItem.querySelector(".plus-btn");
  const quantitySpan = cartItem.querySelector(".quantity");
  const priceP = cartItem.parentElement.parentElement.querySelector(
    ".cart-item__price-wrap"
  );
  let price = removeDotsAndLetters(priceP.textContent);
  const totalP = priceP.parentElement.parentElement.querySelector(
    ".cart-item__total-price"
  );
  let quantity = parseInt(quantitySpan.textContent);

  const updateTotalPrice = () => {
    let totalProduct = totalPrice(quantity, price);
    totalP.textContent = formatNumber(totalProduct);
    updateCartTotal(); // Cập nhật tổng giỏ hàng
  };

  // Sự kiện giảm số lượng
  minusBtn.addEventListener("click", (e) => {
    e.preventDefault();

    if (quantity > 1) {
      --quantity;
      quantitySpan.textContent = quantity;
      updateTotalPrice();
    }
  });

  // Sự kiện tăng số lượng
  plusBtn.addEventListener("click", (e) => {
    e.preventDefault();
    ++quantity;
    quantitySpan.textContent = quantity;
    updateTotalPrice();
  });
});

// Cập nhật tổng giỏ hàng
function updateCartTotal() {
  let total = 0;
  let stock = 0;
  cartItems.forEach((cartItem) => {
    const priceP = cartItem.parentElement.parentElement.querySelector(
      ".cart-item__price-wrap"
    );
    const quantity = cartItem.querySelector(".quantity");
    let totalQty = parseInt(removeDotsAndLetters(quantity.textContent));
    const totalP = priceP.parentElement.parentElement.querySelector(
      ".cart-item__total-price"
    );
    let totalProduct = parseFloat(removeDotsAndLetters(totalP.textContent));

    if (!isNaN(totalProduct) && !isNaN(totalQty)) {
      total += totalProduct;
      stock += totalQty;
    }
  });

  printTotals.forEach((printTotal) => {
    printTotal.textContent = formatNumber(total); // Cập nhật tổng giá
  });
  const stockSpan = document.querySelector(".stock");

  stockSpan.textContent = removeDotsAndLetters(formatNumber(stock));

  const spanQtys = document.querySelectorAll("span.quantity");

  spanQtys.forEach((spanQty) => {
    const index = spanQty.getAttribute("data-cart-index");
    const inputQty = document.getElementById(`cartDetails${index}.quantity`);
    inputQty.value = spanQty.innerText;
  });
}

//  submit for,
function submitForm(e) {
  e.preventDefault();
  formOf.submit();
}
const buttonSubmit = document.querySelector(".submit");
if (buttonSubmit) {
  let formOf = buttonSubmit.closest("form");
  if (formOf) {
    buttonSubmit.addEventListener("click", submitForm);
  }
}

const inputRadio1 = document.querySelector(
  "input.payment-item__checkbox-input"
);
if (inputRadio1) {
  const priceShipSpan = inputRadio1.parentElement
    ? inputRadio1.parentElement.querySelector(".format-price")
    : null;
  let currentShip = parseFloat(removeDotsAndLetters(priceShipSpan.textContent));

  const subTotalSpan = document.querySelector("#sub-total");
  let subTotal = parseFloat(removeDotsAndLetters(subTotalSpan.textContent));

  const sumPrice = document.querySelectorAll(".sum-total");
  const shipPrice = document.querySelectorAll(".shipping-price");
  sumPrice.forEach((sum) => {
    let inputPrice = document.querySelector('input#total-place');
    inputPrice.value = currentShip + subTotal ;
    sum.textContent = formatNumber(currentShip + subTotal);
  });

  shipPrice.forEach((ship) => {
    ship.textContent = formatNumber(currentShip);
  });
}

//  check radio

const inputRadio = document.querySelectorAll(
  "input.payment-item__checkbox-input"
);

inputRadio.forEach((radio) => {
  radio.addEventListener("change", (e) => {
    if (e.target.checked) {
      const priceShipSpan = radio.parentElement.querySelector(".format-price");
      let currentShip = parseFloat(
        removeDotsAndLetters(priceShipSpan.textContent)
      );
      const subTotalSpan = document.querySelector("#sub-total");
      let subTotal = parseFloat(removeDotsAndLetters(subTotalSpan.textContent));

      const sumPrice = document.querySelectorAll(".sum-total");
      const shipPrice = document.querySelectorAll(".shipping-price");

      sumPrice.forEach((sum) => {
        let inputPrice = document.querySelector("input#total-place");
        inputPrice.value = currentShip + subTotal;
        sum.textContent = formatNumber(currentShip + subTotal);
      });

      shipPrice.forEach((ship) => {
        ship.textContent = formatNumber(currentShip);
      });
    }
  });
});

// Lấy tất cả các radio button cho địa chỉ
const addressRadio = document.querySelectorAll(".cart-info__checkbox-input");

// Hàm đồng bộ hóa địa chỉ gửi dựa trên địa chỉ được chọn
function syncPostAddress() {
  addressRadio.forEach((address) => {
    if (address.checked) {
      const idAddress = address.getAttribute("data-address-id"); // Lấy data-address-id
      const postAddress = document.querySelector(
        `#address-select-${idAddress}`
      ); // Lấy postAddress tương ứng
      if (postAddress) {
        postAddress.checked = true; // Đánh dấu postAddress tương ứng
      }
    }
  });
}

// Lắng nghe sự kiện change cho mỗi radio button
addressRadio.forEach((address) => {
  address.addEventListener("change", function () {
    syncPostAddress(); // Đồng bộ hóa khi có sự thay đổi
  });
});

// Kiểm tra và đồng bộ khi trang được tải
document.addEventListener("DOMContentLoaded", function () {
  syncPostAddress();
});

function checkAllInput(e) {
  let isChecked = e.target.checked; // Lấy trạng thái checked từ sự kiện
  
  const inputCheck = document.querySelectorAll("input.checkbox");
  inputCheck.forEach((check) => {
    check.checked = isChecked; // Đặt trạng thái cho từng checkbox
  });
}

// Hàm kiểm tra trạng thái của từng checkbox
function checkIndividualInput() {
  const inputCheck = document.querySelectorAll("input.checkbox");
  const checkAllBox = document.querySelector(".check-all-box");

  // Kiểm tra xem có checkbox nào không được chọn hay không
  const allChecked = Array.from(inputCheck).every((check) => check.checked);
  checkAllBox.checked = allChecked; // Đặt trạng thái cho checkbox "Chọn tất cả"
}

// Gán sự kiện cho checkbox "Chọn tất cả"
const challBox = document.querySelector(".check-all-box") ;
if(challBox){
  document.querySelector(".check-all-box").addEventListener('change', checkAllInput);

}

// Gán sự kiện cho các checkbox cá nhân
const inputCheck = document.querySelectorAll("input.checkbox");
inputCheck.forEach((check) => {
  check.addEventListener('change', checkIndividualInput);
});


const checkAll = document.querySelectorAll(".check-all-box");

if (checkAll) {
  checkAll.forEach((checkall) => {
    checkall.addEventListener("change", checkAllInput);
  });
}
