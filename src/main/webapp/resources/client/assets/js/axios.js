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
      if (response.data !== "added") {
        addItem(parseInt(qtyProduct.textContent) + 1);
        qtyProduct.textContent = parseInt(qtyProduct.textContent) + 1;

        swal("Thành công", response.data, "success");
      } else {
        swal("Thành công", "Thêm giỏ hàng thành công", "success");
      }
    })
    .catch((error) => {
      // swal("Lỗi", error.message, "error");
      window.location.href = "/login"; // Đường dẫn đến trang đăng nhập
      swal("Lỗi", "Hãy đăng nhập để tiếp tục", "error");
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

function generateSessionId() {
  return "session-" + Math.random().toString(36).substr(2, 9);
}

let sessionId = localStorage.getItem("sessionId");
if (!sessionId) {
  sessionId = generateSessionId();
  localStorage.setItem("sessionId", sessionId);
}

const sendVerify = (url) => {
  showLoading();

  axios
    .get(url, { params: { sessionId: sessionId } })

    .then((response) => {
      swal("Thành công", response.data.message, "success");
    })

    .catch((error) => {
      swal("Có lỗi xảy ra", " Vui lòng thử lại sau", "error");
      console.log(error);
    });
};

const resetPss = (url, email) => {
  showLoading();

  axios
    .get(url, { params: { email: email } })

    .then((response) => {
      console.log(response.data);
      if (response.data.status == "error") {
        throw new Error(response.data.message); // Ném lỗi với thông báo cụ thể
      }

      swal("Thành công", response.data.message, "success");
    })

    .catch((error) =>
      swal("Lỗi", error.message || "Đã xảy ra lỗi. Vui lòng thử lại.", "error")
    );
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
        const remainingTime = Math.floor(
          (countdownEndTime - new Date().getTime()) / 1000
        );
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
        // console.log(url);
        sendVerify(url);
        startCountdown(30, a, id);
      });
    });
  }
});

document.addEventListener("DOMContentLoaded", function () {
  const resetMails = document.querySelectorAll(".submit-reset");
  if (resetMails) {
    resetMails.forEach((btn) => {
      const parentElement = btn.closest("form");
      if (parentElement) {
        const id = parentElement.getAttribute("id");
        const countdownEndTime = localStorage.getItem(`countdownEndTime_${id}`);
        const pAlert = btn.parentElement.querySelector("#wait-p");
        if (countdownEndTime) {
          const remainingTime = Math.floor(
            (countdownEndTime - new Date().getTime()) / 1000
          );
          if (remainingTime > 0) {
            btn.classList.add("d-none");
            pAlert.classList.remove("d-none");

            pAlert.textContent = remainingTime + " giây"; // Thiết lập ngay khi load trang

            startCountdown2(remainingTime, btn, pAlert, id);
          } else {
            btn.classList.remove("d-none");
            btn.classList.remove("disable");
            pAlert.classList.add("d-none");

            btn.textContent = "Gửi lại";
            localStorage.removeItem(`countdownEndTime_${id}`);
          }
        }

        btn.addEventListener("click", function (e) {
          e.preventDefault();
          const url = parentElement.getAttribute("action");
          const elementMail =
            parentElement.parentElement.querySelector("input.email");
          let email = elementMail.value;

          resetPss(url, email);
          startCountdown2(30, btn, pAlert, id);
        });
      }

      // console.log(url);
    });
  }
});

function startCountdown2(duration, a, p, id) {
  const now = new Date().getTime();
  const endTime = now + duration * 1000;

  // Lưu thời gian kết thúc vào localStorage với id riêng của phần tử
  localStorage.setItem(`countdownEndTime_${id}`, endTime);

  const countdownInterval = setInterval(() => {
    const currentTime = new Date().getTime();
    const remainingTime = endTime - currentTime;

    if (remainingTime > 0) {
      const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
      a.classList.add("disable");
      a.classList.add("d-none");
      p.classList.remove("d-none");

      p.textContent = seconds + " giây";
    } else {
      clearInterval(countdownInterval);
      a.classList.remove("disable");
      a.classList.remove("d-none");
      p.classList.add("d-none");
      a.textContent = "Gửi lại";
      localStorage.removeItem(`countdownEndTime_${id}`);
    }
  }, 1000);
}

function startCountdown2(duration, a, p, id) {
  const now = new Date().getTime();
  const endTime = now + duration * 1000;

  // Lưu thời gian kết thúc vào localStorage với id riêng của phần tử
  localStorage.setItem(`countdownEndTime_${id}`, endTime);

  const countdownInterval = setInterval(() => {
    const currentTime = new Date().getTime();
    const remainingTime = endTime - currentTime;

    if (remainingTime > 0) {
      const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
      a.classList.add("disable");
      a.classList.add("d-none");
      p.classList.remove("d-none");
      p.textContent = seconds + " giây";
    } else {
      clearInterval(countdownInterval);
      p.classList.add("d-none");
      a.classList.remove("d-none");
      a.classList.remove("disable");
      a.textContent = "Gửi lại";
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

// cancel Order
function handelDisable(checks) {
  checks.forEach(function (checkbox) {
    if (checkbox.checked) {
      checkbox.classList.add("d-none");
      document.querySelector(".check-all-box").classList.add("d-none");
    }
  });
}
function sendCancel(e) {
  e.preventDefault();
  let url = e.target.href;
  const checks = document.querySelectorAll(
    'input.checkbox[type="checkbox"][name="shipping-adress"]'
  );
  const selectedValues = [];

  checks.forEach(function (checkbox) {
    if (checkbox.checked) {
      selectedValues.push(checkbox.value);
    }
  });

  let selectVal = selectedValues.join(",");

  if (selectVal.length === 0) {
    swal("Lỗi", "Bạn chưa chọn đơn hàng nào.", "error");
    return; // Nếu không có đơn hàng nào được chọn, dừng lại.
  }

  // Hiển thị hộp thoại xác nhận trước khi huỷ
  swal({
    title: "Bạn có chắc chắn muốn huỷ các đơn hàng này?",
    text: "Hành động này sẽ không thể hoàn tác!",
    icon: "warning",
    buttons: ["Hủy", "Đồng ý"],
    dangerMode: true, // Hiển thị chế độ cảnh báo
  }).then((willCancel) => {
    if (willCancel) {
      // Nếu người dùng chọn đồng ý huỷ
      axios
        .get(url, {
          params: {
            selectedAddresses: selectVal, // Truyền danh sách địa chỉ dưới dạng query params
          },
          headers: {
            "X-CSRF-TOKEN": csrfToken, // Thêm CSRF token nếu cần
          },
        })
        .then((response) => {
          handelDisable(checks); // Xử lý disable các checkbox sau khi huỷ
          swal("Thành công", response.data.message, "success");
        })
        .catch((error) => {
          // Hiển thị thông báo lỗi nếu có
          swal(
            "Lỗi",
            error.response?.data?.message || "Đã xảy ra lỗi. Vui lòng thử lại.",
            "error"
          );
        });
    } else {
      swal("Đã huỷ hành động", "Đơn hàng của bạn vẫn chưa bị huỷ", "info");
    }
  });
}

const btnSend = document.querySelector(".cart-info__checkout-all");

if (btnSend) {
  btnSend.addEventListener("click", (e) => sendCancel(e));
}

function openWithdrawModal() {
  const modal = document.getElementById("withdrawModal2024");

  modal.style.display = "flex";
  anime({
    targets: ".ctv-withdraw-2024 .w24-modal-content",
    translateY: [20, 0],
    opacity: [0, 1],
    duration: 500,
    easing: "easeOutCubic",
  });
}

function closeWithdrawModal() {
  anime({
    targets: ".ctv-withdraw-2024 .w24-modal-content",
    translateY: [0, 20],
    opacity: [1, 0],
    duration: 300,
    easing: "easeInCubic",
    complete: function () {
      document.getElementById("withdrawModal2024").style.display = "none";
      document.getElementById("withdrawForm").reset();
    },
  });
}

function formatAmount(input) {
  let value = input.value.replace(/\D/g, "");
  if (value > 50000000) value = 50000000;
  if (value < 0) value = 0;
  input.value = value;

  const formatted = new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: "VND",
  }).format(value);

  document.getElementById("amountError").textContent =
    value < 100000 ? "Số tiền tối thiểu là 100,000đ" : "";
}

function handleWithdraw(event) {
  event.preventDefault();
  const submitBtn = document.getElementById("submitBtn");
  const loading = document.getElementById("withdrawLoading");

  submitBtn.disabled = true;
  loading.style.display = "flex";

  // Simulate API call
  setTimeout(() => {
    loading.style.display = "none";
    showSuccess();
  }, 2000);
}

function showSuccess() {
  const modalContent = document.querySelector(
    ".ctv-withdraw-2024 .w24-modal-content"
  );
  modalContent.innerHTML = `
        <div style="text-align: center;">
            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                <polyline points="22 4 12 14.01 9 11.01"></polyline>
            </svg>
            <h2 style="margin: 1rem 0;">Thành Công!</h2>
            <p style="margin-bottom: 2rem;">
                Yêu cầu rút tiền đã được gửi.<br>
                Chúng tôi sẽ xử lý trong vòng 24h.
            </p>
            <button class="w24-submit-btn" onclick="closeWithdrawModal()">Đóng</button>
        </div>
    `;
}

// Close modal when clicking outside
const closeWidthdraw = document.getElementById("withdrawModal2024");
if (closeWidthdraw)
  closeWidthdraw.addEventListener("click", function (e) {
    if (e.target == this) {
      closeWithdrawModal();
    }
  });

function formatDate(dateString) {
  const options = { year: "numeric", month: "2-digit", day: "2-digit" };
  return new Date(dateString).toLocaleDateString("vi-VN", options);
}

function processOrderDate(orderDate) {
  // Tạo đối tượng Date từ từng phần tử trong mảng
  const date = new Date(
    orderDate[0],
    orderDate[1] - 1,
    orderDate[2],
    orderDate[3],
    orderDate[4],
    orderDate[5]
  );
  const formattedDate = date.toLocaleString("vi-VN", {
    weekday: "long", // Tên ngày trong tuần
    year: "numeric", // Năm
    month: "long", // Tháng
    day: "numeric", // Ngày
    hour: "2-digit", // Giờ (2 chữ số)
    minute: "2-digit", // Phút (2 chữ số)
    second: "2-digit", // Giây (2 chữ số)
    hour12: false, // Định dạng 24 giờ
  });
  const cleanedDate = formattedDate
    .replace("Thứ Hai", "T2")
    .replace("Thứ Ba", "T3")
    .replace("Thứ Tư", "T4")
    .replace("Thứ Năm", "T5")
    .replace("Thứ Sáu", "T6")
    .replace("Thứ Bảy", "T7")
    .replace("Chủ Nhật", "CN")
    .replace("Tháng ", "T")
    .replace("tháng ", "T")
    .replace("lúc ", ""); // Loại bỏ từ "lúc"
  return cleanedDate;
}

function formatCurrency(amount) {
  return new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: "VND",
  }).format(amount);
}

function handleWithdraw() {
  // Implement withdraw functionality
  console.log("Withdraw clicked");
}

function showLoading(elementId) {
  const element = document.getElementById(elementId);
  element.innerHTML = `
            <tr>
                <td colspan="6">
                    <div class="loading">
                        <div class="loading-spinner"></div>
                    </div>
                </td>
            </tr>
        `;
}

// All JavaScript functions are namespaced with ctv_

function ctv_handleReferral() {
  const modal = document.getElementById("ctv_dash_v2_referralModal");
  modal.style.display = "flex";
  modal.innerHTML = `
              <div class="ctv_dash_v2_modal_content">
                  <button class="ctv_dash_v2_modal_close" onclick="ctv_closeModal('ctv_dash_v2_referralModal')">&times;</button>
                  <h2 style ="font-weight: bold;
    font-size: 2rem;">Danh Sách Khách Hàng</h2>
                  <div class="ctv_dash_v2_table_wrapper">
                      <div class="ctv_dash_v2_loading">
                          <div class="ctv_dash_v2_spinner"></div>
                      </div>
                  </div>
              </div>
          `;

  // Simulate API call
  setTimeout(ctv_loadCustomerData, 1000);
}

function ctv_handleAnalytics() {
  const modal = document.getElementById("ctv_dash_v2_analyticsModal");
  modal.style.display = "flex";
  modal.innerHTML = `
              <div class="ctv_dash_v2_modal_content" id="tableWrapper">
                  <button class="ctv_dash_v2_modal_close" onclick="ctv_closeModal('ctv_dash_v2_analyticsModal')">&times;</button>
                  <h2 style ="font-weight: bold;
    font-size: 2rem;">Lịch Sử Đơn Hàng</h2>
                  <div class="ctv_dash_v2_table_wrapper">
                      <div class="ctv_dash_v2_loading">
                          <div class="ctv_dash_v2_spinner"></div>
                      </div>
                  </div>
              </div>
          `;

  // Simulate API call
  setTimeout(ctv_loadOrderData, 1000);
}

function ctv_closeModal(modalId) {
  const modal = document.getElementById(modalId);
  anime({
    targets: `#${modalId} .ctv_dash_v2_modal_content`,
    opacity: 0,
    scale: 0.9,
    duration: 300,
    easing: "easeInOutQuad",
    complete: () => {
      modal.style.display = "none";
    },
  });
}

// Add more JavaScript functions as needed

// Initialize animations
document.addEventListener("DOMContentLoaded", () => {
  anime({
    targets: ".ctv_dash_v2_container",
    opacity: [0, 1],
    translateY: [20, 0],
    duration: 800,
    easing: "easeOutExpo",
  });
});

function ctv_loadCustomerData() {
  const tableWrapper = document.querySelector(
    "#ctv_dash_v2_referralModal .ctv_dash_v2_table_wrapper"
  );

  const fetchData = async () => {
    const loadingHTML = `
    <div style="text-align: center; padding: 20px;">
      <div class="loading-spinner"></div>
      <p>Đang tải dữ liệu...</p>
    </div>
  `;
    const response = await axios.get("/get-customer-by-ref");
    const customers = response.data.content;

    const tableHTML = `
      <table class="ctv_dash_v2_table">
        <thead>
            <tr>
                <th>Mã KH</th>
                <th>Họ Tên</th>
                <th>Số Đơn</th>
                <th>Tổng Giá Trị</th>
                <th>Trạng Thái</th>
              
            </tr>
        </thead>
        <tbody>
            ${customers
              .map(
                (customer) => `
                <tr>
                    <td>#${customer.customerCode}</td>
                    <td>${customer.nameCustomer}</td>
                    <td>${customer.countOrders}</td>
                    <td>${formatNumber(customer.subTotal)}</td>
                    <td>
                        <span class="ctv_dash_v2_status ctv_dash_v2_status_${
                          customer.enabled == true ? "active" : "inactive"
                        }">


                            ${
                              customer.enabled === true
                                ? "Hoạt động"
                                : "Tạm khoá "
                            }
                        </span>
                    </td>
                   
                </tr>
            `
              )
              .join("")}
        </tbody>
    </table>
`;

    tableWrapper.innerHTML = tableHTML;
    anime({
      targets: "#ctv_dash_v2_referralModal .ctv_dash_v2_modal_content",
      opacity: [0, 1],
      scale: [0.9, 1],
      duration: 300,
      easing: "easeOutExpo",
    });
  };
  fetchData();

  // Animation cho modal content
  
}

function fixInvalidJson(invalidJson) {
  try {
    // Loại bỏ các ký tự thừa có thể
    const correctedJson = invalidJson
      .replace(/,(?=\s*[\]}])/g, "") // Xóa dấu phẩy thừa
      .replace(/[\]}]+$/g, "") // Xóa các dấu đóng dư thừa ở cuối
      .replace(/([{[])\s*(,)/g, "$1") // Xóa dấu phẩy thừa ngay sau dấu mở
      .replace(/}\s*}/g, "}"); // Xóa các cặp đóng không khớp

    // Thử parse JSON
    console.log(correctedJson);

    const parsed = JSON.parse(correctedJson);
    return parsed;
  } catch (error) {
    console.error("Không thể sửa JSON:", error.message);
    throw new Error("JSON vẫn không hợp lệ sau khi chỉnh sửa.");
  }
}

function ctv_loadOrderData() {
  const tableWrapper = document.querySelector(
    "#ctv_dash_v2_analyticsModal .ctv_dash_v2_table_wrapper"
  );

  // Dữ liệu mẫu - trong thực tế sẽ được lấy từ API

  // Function to format price to VND
  const formatPrice = (price) => {
    return new Intl.NumberFormat("vi-VN", {
      style: "currency",
      currency: "VND",
    }).format(price);
  };

  // Function to get status badge
  const getStatusBadge = (status) => {
    const statusMap = {
      PENDING: { color: "#ffd700", text: "Chờ Xử Lý" },
      PROCESSING: { color: "#1e90ff", text: "Đang Xử Lý" },
      COMPLETED: { color: "#32cd32", text: "Hoàn Thành" },
      CANCELLED: { color: "#ff4500", text: "Đã Hủy" },
    };

    const statusInfo = statusMap[status] || { color: "#808080", text: status };
    return `<span style="
    background-color: ${statusInfo.color}; 
    color: white;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 0.9em;
    font-weight: 500;">${statusInfo.text}</span>`;
  };

  const getOrders = async () => {
    try {
      const loadingHTML = `
      <div style="text-align: center; padding: 20px;">
        <div class="loading-spinner"></div>
        <p>Đang tải dữ liệu...</p>
      </div>
    `;
      tableWrapper.innerHTML = loadingHTML;

      const response = await axios.get("/get-order-by-ref");
      ///  console.log(response.data);

      // Ví dụ sử dụng
      const data = response.data;

      const orders = data.content;
      console.log(orders);

      if (!orders || orders.length === 0) {
        tableWrapper.innerHTML = `
        <div style="text-align: center; padding: 20px;">
          <p>Không có đơn hàng nào.</p>
        </div>
      `;
        return;
      }

      const tableHTML = `
      <table class="ctv_dash_v2_table">
          <thead>
              <tr>
                  <th>Mã ĐH</th>
                  <th>Khách Hàng</th>
                  <th>Ngày Đặt</th>
                  <th>Giá Trị</th>
                  <th>Hoa Hồng</th>
                  <th>Trạng Thái</th>
                
              </tr>
          </thead>
          <tbody>
              ${orders
                .map(
                  (order) => `
                  <tr>
                      <td>${order.id}</td>
                      <td>${order.receiverName}</td>
                      <td>${processOrderDate(order.orderDate)}</td>
                      <td class ="format-price">${formatPrice(
                        order.totalPrice
                      )}</td>
                      <td>${order.commission}</td>
                      <td>
                          <span class="ctv_dash_v2_status ctv_dash_v2_status_${
                            order.status
                          }">
                              ${
                                order.status === "completed"
                                  ? "Hoàn thành"
                                  : order.status === "pending"
                                  ? "Chờ xử lý"
                                  : "Đang xử lý"
                              }
                          </span>
                      </td>
                      
                  </tr>
              `
                )
                .join("")}
          </tbody>
      </table>
  `;

      tableWrapper.innerHTML = tableHTML;

      // Add animation
      anime({
        targets: "table tr",
        opacity: [0, 1],
        translateY: [20, 0],
        delay: anime.stagger(100),
      });
    } catch (error) {
      console.error("Lỗi khi tải dữ liệu:", error);
      tableWrapper.innerHTML = `
      <div style="
        text-align: center;
        padding: 20px;
        color: #ff0000;
      ">
        <p>Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau.</p>
      </div>
    `;
    }
  };

  // Add necessary CSS
  const style = document.createElement("style");
  style.textContent = `
  .loading-spinner {
    width: 50px;
    height: 50px;
    border: 5px solid #f3f3f3;
    border-top: 5px solid #009879;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  @media (max-width: 768px) {
    table {
      font-size: 0.8em;
    }
    
    td, th {
      padding: 8px 10px !important;
    }
    
    button {
      padding: 4px 8px !important;
      font-size: 0.9em;
    }
  }
`;

  document.head.appendChild(style);

  // Initialize
  getOrders();

  // Animation cho modal content
  anime({
    targets: "#ctv_dash_v2_analyticsModal .ctv_dash_v2_modal_content",
    opacity: [0, 1],
    scale: [0.9, 1],
    duration: 300,
    easing: "easeOutExpo",
  });
}

// Thêm event listener cho click outside modal để đóng
document.addEventListener("click", (e) => {
  const modals = document.getElementsByClassName("ctv_dash_v2_modal");
  Array.from(modals).forEach((modal) => {
    if (e.target === modal) {
      ctv_closeModal(modal.id);
    }
  });
});
