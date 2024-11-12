// Cart
function addItem(stock) {
  const title = document.querySelector(
    ".act-dropdown__top .act-dropdown__title"
  );
  if (stock <= 3) {
    title.textContent = `Bạn có ${stock} sản phẩm trong giỏ hàng`;
  } else {
    title.textContent = ` 3/${stock} sản phẩm trong giỏ hàng`;
  }
  const dropdown = document.getElementById("dropdown__list");

  const colElements = dropdown.getElementsByClassName("col");
  if (colElements == null || colElements.length < 3) {
    const src = document.querySelector(".prod-preview__img").src;
    const name = document.querySelector(".prod-info__heading").textContent;
    const price = document.querySelector(".prod-info__total-price").innerText;

    const item = document.createElement("div");
    item.classList.add("col");
    item.innerHTML = `
  <article class="cart-preview-item">
    <div class="cart-preview-item__img-wrap">
      <img src="${src}" alt="${name}"   class="cart-preview-item__thumb" >
    </div>
    <h3 class="cart-preview-item__title">${name}</h3>
    <p class="cart-preview-item__price format-price">${price}</p>
  </article>
`;
    dropdown.appendChild(item);
  }
}

const csrfToken = document
  .querySelector('meta[name="_csrf"]')
  .getAttribute("content");

function addToCart(url, quantity, qtyProduct) {
  axios
    .get(url, {
      params: {
        quantity: quantity,
      },
      headers: {
        "X-CSRF-TOKEN": csrfToken, // Thêm CSRF token nếu cần
      },
    })
    .then((response) => {
      console.log(response.data); // 'Sản phẩm đã được thêm vào giỏ hàng'
      if (response.data !== "added") {
        addItem(parseInt(qtyProduct.textContent) + 1);
        qtyProduct.textContent = parseInt(qtyProduct.textContent) + 1;

        swal("Thành công", response.data, "success");
      } else {
        swal("Thành công", "Thêm giỏ hàng thành công", "success");
      }
    })
    .catch((error) => {
      swal("Lỗi", error.message, "error");
    });
}

const btnAddToCarts = document.querySelectorAll(".add-product");

if (btnAddToCarts) {
  btnAddToCarts.forEach((btn) => {
    btn.addEventListener("click", function (e) {
      const qtyProduct = document.querySelector("span.top-act__title");

      e.preventDefault();
      const form = btn.closest("form");
      const url = form.action;

      // Lấy giá trị quantity từ input (thay vì textContent)
      let quantity = document.getElementById("quantity-submit").value; // Assuming your quantity input has id="quantity-submit"
      addToCart(url, quantity, qtyProduct);
    });
  });
}

// mail

function showLoading() {
  swal({
    buttons: false, // Không có nút bấm
    closeOnClickOutside: false, // Không đóng khi nhấn ngoài swal
    closeOnEsc: false, // Không đóng khi nhấn ESC
    timer: 0, // Không tự động đóng
    content: {
      element: "div", // Dùng div để chứa cả ảnh và văn bản
      attributes: {
        innerHTML: `
          <img src="/client/assets/icons/load.svg" style="width: 8rem; height: 8rem;" />
          <div class="swal-title" style="">Xin chờ...</div>
<div class="swal-text" style="">Đang xử lí yêu cầu của bạn...</div>        `, // HTML tùy chỉnh cho ảnh và văn bản
      },
    },
  });
}

// Gọi hàm này khi bắt đầu quá trình cần tải

//  create sessionId
function generateSessionId() {
  return "session-" + Math.random().toString(36).substr(2, 9);
}

let sessionId = localStorage.getItem("sessionId");
if (!sessionId) {
  sessionId = generateSessionId();
  localStorage.setItem("sessionId", sessionId);
}

function checkResendEmail() {
  axios
    .get("/can-resend-email", {
      params: { sessionId: sessionId },
    })

    .then((response) => console.log(response.data))

    .catch((error) => console.log(error));
}

const sendVerify = (url) => {
  showLoading();

  axios
    .get(url, { params: { sessionId: sessionId } })

    .then((response) => {
      swal("Thành công", response.data.message, "success");
    })

    .catch((error) => swal("Có lỗi xảy ra", " Vui lòng thử lại sau", "error"));
};



document.addEventListener("DOMContentLoaded", function () {
  const verifyEmls = document.querySelectorAll(".submit-verify");
  if (verifyEmls) {
    verifyEmls.forEach((a) => {
      const parent = a.closest("div");
      const id = parent.getAttribute("id"); // Giả sử mỗi `div` có một id duy nhất
      const countdownEndTime = localStorage.getItem(`countdownEndTime_${id}`);

      // Nếu còn thời gian đếm ngược, thiết lập nội dung và tiếp tục đếm ngược
      if (countdownEndTime) {
        const remainingTime = Math.floor((countdownEndTime - new Date().getTime()) / 1000);
        if (remainingTime > 0) {
          a.classList.add("disable");
          a.textContent = remainingTime + " giây"; // Thiết lập ngay khi load trang
          startCountdown(remainingTime, a, id);
        } else {
          a.textContent = "Gửi lại";
          localStorage.removeItem(`countdownEndTime_${id}`);
        }
      }

      a.addEventListener("click", function (e) {
        e.preventDefault();
        const url = parent.getAttribute("action");
        console.log(url);
        sendVerify(url);
        startCountdown(30, a, id);
      });
    });
  }
});

function startCountdown(duration, element, id) {
  const now = new Date().getTime();
  const endTime = now + duration * 1000;

  // Lưu thời gian kết thúc vào localStorage với id riêng của phần tử
  localStorage.setItem(`countdownEndTime_${id}`, endTime);

  const countdownInterval = setInterval(() => {
    const currentTime = new Date().getTime();
    const remainingTime = endTime - currentTime;

    if (remainingTime > 0) {
      const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
      element.classList.add("disable");
      element.textContent = seconds + " giây";
    } else {
      clearInterval(countdownInterval);
      element.classList.remove("disable");
      element.textContent = "Gửi lại";
      localStorage.removeItem(`countdownEndTime_${id}`);
    }
  }, 1000);
}


function startCountdown(duration, element, id) {
  const now = new Date().getTime();
  const endTime = now + duration * 1000;

  // Lưu thời gian kết thúc vào localStorage với id riêng của phần tử
  localStorage.setItem(`countdownEndTime_${id}`, endTime);

  const countdownInterval = setInterval(() => {
    const currentTime = new Date().getTime();
    const remainingTime = endTime - currentTime;

    if (remainingTime > 0) {
      const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
      element.classList.add("disable");
      element.textContent = seconds + " giây";
    } else {
      clearInterval(countdownInterval);
      element.classList.remove("disable");
      element.textContent = "Gửi lại";
      localStorage.removeItem(`countdownEndTime_${id}`);
    }
  }, 1000);
}

// change Qty

function changeQty(id, quantity) {
  axios.get(`/update-cart-detail/${id}`, {
    params: {
      quantity: quantity,
    },
    headers: {
      "X-CSRF-TOKEN": csrfToken, // Thêm CSRF token nếu cần
    },
  });
}

const btnUp = document.querySelectorAll(".plus-btn");
if (btnUp) {
  btnUp.forEach((btn) => {
    btn.addEventListener("click", function () {
      const quantityElement = btn.parentElement.querySelector(".quantity");
      const index = quantityElement.getAttribute("data-cart-index");

      const inputId = document.getElementById(`cartDetails${index}.id`);
      const productId = inputId.value;
      const inputQuantity = document.getElementById(
        `cartDetails${index}.quantity`
      );
      let quantity = parseInt(inputQuantity.value) + 1;

      changeQty(productId, quantity);
    });
  });
}

const btnDown = document.querySelectorAll(".minus-btn");
if (btnDown) {
  btnDown.forEach((btn) => {
    btn.addEventListener("click", function () {
      const quantityElement = btn.parentElement.querySelector(".quantity");
      const index = quantityElement.getAttribute("data-cart-index");

      const inputId = document.getElementById(`cartDetails${index}.id`);
      const productId = inputId.value;
      const inputQuantity = document.getElementById(
        `cartDetails${index}.quantity`
      );
      let quantity = parseInt(inputQuantity.value) - 1;

      changeQty(productId, quantity);
    });
  });
}
