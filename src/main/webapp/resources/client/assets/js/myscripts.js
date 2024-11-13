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

//  submit form,
function submitForm(e) {
  e.preventDefault();
  formOf.submit();
}
const buttonSubmits = document.querySelectorAll(".submit");
if (buttonSubmits) {
  buttonSubmits.forEach((buttonSubmit) => {
    let formOf = buttonSubmit.closest("form");
    if (formOf) {
      buttonSubmit.addEventListener("click", submitForm);
    }
  });
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
    let inputPrice = document.querySelector("input#total-place");
    inputPrice.value = currentShip + subTotal;
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
const challBox = document.querySelector(".check-all-box");
if (challBox) {
  document
    .querySelector(".check-all-box")
    .addEventListener("change", checkAllInput);
}

// Gán sự kiện cho các checkbox cá nhân
const inputCheck = document.querySelectorAll("input.checkbox");
inputCheck.forEach((check) => {
  check.addEventListener("change", checkIndividualInput);
});

const checkAll = document.querySelectorAll(".check-all-box");

if (checkAll) {
  checkAll.forEach((checkall) => {
    checkall.addEventListener("change", checkAllInput);
  });
}

// Lấy tất cả các phần tử select cho tỉnh, quận, và xã
function compareString(str1, str2) {
  // Loại bỏ dấu cách và chuyển chuỗi về chữ thường
  let cleanedStr1 = str1.replace(/\s+/g, "").toLowerCase();
  let cleanedStr2 = str2.replace(/\s+/g, "").toLowerCase();

  return cleanedStr1 === cleanedStr2;
}

document.addEventListener("DOMContentLoaded", function () {
  const tinhSelectsUpdate = document.querySelectorAll(".tinh.update");
  const quanSelectsUpdate = document.querySelectorAll(".quan.update");

  // Hàm để cập nhật danh sách phường/xã khi chọn quận/huyện
  function updatePhuongOptions(quanId, phuongSelect) {
    // Gọi API để lấy danh sách phường/xã dựa trên `quanId`
    fetch(`https://esgoo.net/api-tinhthanh/3/${quanId}.htm`)
      .then((response) => response.json())
      .then((data_phuong) => {
        if (data_phuong.error === 0) {
          // Xóa dữ liệu phường/xã cũ
          phuongSelect.innerHTML = "";
          // Đổ dữ liệu phường/xã vào dropdown
          data_phuong.data.forEach((val_phuong) => {
            const option = document.createElement("option");
            option.setAttribute("phuongid", val_phuong.id);
            option.value = val_phuong.full_name + "," + val_phuong.id;
            option.textContent = val_phuong.full_name;
            phuongSelect.appendChild(option);
          });
        } else {
          console.log("Không có dữ liệu phường/xã cho quận/huyện này.");
        }
      })
      .catch((error) => console.error("Lỗi khi gọi API phường/xã:", error));
  }

  // Hàm để cập nhật dữ liệu quận/huyện khi chọn tỉnh
  tinhSelectsUpdate.forEach((tinh) => {
    const tinhOption = tinh.querySelector(".firtsOption");
    if (tinhOption) {
      const tinhId = tinhOption.getAttribute("tinhid");

      // Gọi API để lấy danh sách quận/huyện dựa trên `tinhId`
      fetch(`https://esgoo.net/api-tinhthanh/2/${tinhId}.htm`)
        .then((response) => response.json())
        .then((data_quan) => {
          if (data_quan.error === 0) {
            const quanSelect = tinh
              .closest(".address-group")
              .querySelector(".quan");
            quanSelect.innerHTML = ""; // Xóa dữ liệu quận/huyện cũ
            data_quan.data.forEach((val_quan) => {
              const option = document.createElement("option");
              option.setAttribute("quanid", val_quan.id);
              option.value = val_quan.full_name + "," + val_quan.id;
              option.textContent = val_quan.full_name;
              quanSelect.appendChild(option);
            });

            const firstQuanOption = quanSelect.querySelector(".firtsOption");
            if (firstQuanOption) {
              const firstQuanId = firstQuanOption.getAttribute("quanid");
              const phuongSelect = tinh
                .closest(".address-group")
                .querySelector(".phuong");
              updatePhuongOptions(firstQuanId, phuongSelect);
            }
          } else {
            console.log("Không có dữ liệu quận/huyện cho tỉnh này.");
          }
        })
        .catch((error) => console.error("Lỗi khi gọi API quận/huyện:", error));
    } else {
      console.log("Không tìm thấy option đầu tiên trong dropdown tỉnh.");
    }
  });

  quanSelectsUpdate.forEach((quan) => {
    const firstQuanOption = quan.querySelector(".firtsOption");
    if (firstQuanOption) {
      const firstQuanId = firstQuanOption.getAttribute("quanid");
      const phuongSelect = quan
        .closest(".address-group")
        .querySelector(".phuong");
      updatePhuongOptions(firstQuanId, phuongSelect);
    }
    // Cập nhật danh sách phường/xã khi chọn quận/huyện
    quan.addEventListener("change", function () {
      const selectedOption = this.options[this.selectedIndex];
      const idquan = selectedOption.getAttribute("quanId");

      // Lấy phường xã cho quận/huyện đã chọn
      fetch(`https://esgoo.net/api-tinhthanh/3/${idquan}.htm`)
        .then((response) => response.json())
        .then((data_phuong) => {
          if (data_phuong.error === 0) {
            // Reset xã/phường khi quận/huyện thay đổi
            const phuongSelect = quan
              .closest(".address-group")
              .querySelector(".phuong");
            phuongSelect.innerHTML = '<option value="0">Phường Xã</option>';

            // Đổ dữ liệu phường/xã vào select tương ứng
            data_phuong.data.forEach((val_phuong) => {
              const option = document.createElement("option");
              option.value = val_phuong.full_name + "," + val_phuong.id;

              option.textContent = val_phuong.full_name;
              phuongSelect.appendChild(option);
            });
          }
        });
    });

    // quan.addEventListener("change", (event) => {
    //   const quanId =
    //     event.target.options[event.target.selectedIndex].getAttribute("quanid");
    //   const phuongSelect = quan
    //     .closest(".address-group")
    //     .querySelector(".phuong");
    //   if (quanId) {
    //     updatePhuongOptions(quanId, phuongSelect);
    //   }
    // });
  });

  // Hàm để cập nhật dữ liệu phường/xã khi chọn quận/huyện
  function updatePhuongOptions(quanId, quanSelect) {
    fetch(`https://esgoo.net/api-tinhthanh/3/${quanId}.htm`)
      .then((response) => response.json())
      .then((data_phuong) => {
        const phuongSelect = quanSelect
          .closest(".address-group")
          .querySelector(".phuong");

        // Đổ dữ liệu phường/xã vào dropdown
        if (data_phuong.error === 0) {
          data_phuong.data.forEach((val_phuong) => {
            const option = document.createElement("option");
            option.value = val_phuong.full_name + "," + val_phuong.id;
            option.textContent = val_phuong.full_name;
            phuongSelect.appendChild(option);
          });
        } else {
          console.log("Không có dữ liệu phường/xã cho quận này.");
        }
      })
      .catch((error) => console.error("Lỗi khi gọi API phường/xã:", error));
  }

  quanSelectsUpdate.forEach((quan) => {
    quan.addEventListener("change", function () {
      const quanId = this.options[this.selectedIndex].getAttribute("quanid");
      updatePhuongOptions(quanId, this);
    });
  });

  // Lấy tất cả các phần tử select cho tỉnh, quận, và xã
  const tinhSelects = document.querySelectorAll(".tinh");
  // Fetch danh sách tỉnh/thành
  fetch("https://esgoo.net/api-tinhthanh/1/0.htm")
    .then((response) => response.json())
    .then((data_tinh) => {
      if (data_tinh.error === 0) {
        // Đổ dữ liệu vào tất cả các select của tỉnh/thành
        tinhSelects.forEach((tinhSelect) => {
          data_tinh.data.forEach((val_tinh) => {
            const option = document.createElement("option");
            option.classList.add("option-address");

            option.setAttribute("tinhid", val_tinh.id);
            option.value = val_tinh.full_name + "," + val_tinh.id;
            option.textContent = val_tinh.full_name;
            tinhSelect.appendChild(option);
          });

          // Xử lý khi người dùng chọn tỉnh/thành
          tinhSelect.addEventListener("change", function () {
            const selectedOption = this.options[this.selectedIndex];
            const idtinh = selectedOption.getAttribute("tinhid");

            // Lấy quận huyện cho tỉnh/thành đã chọn
            fetch(`https://esgoo.net/api-tinhthanh/2/${idtinh}.htm`)
              .then((response) => response.json())
              .then((data_quan) => {
                if (data_quan.error === 0) {
                  // Lấy phần tử quận/huyện và xã/phường cùng nhóm
                  const quanSelect =
                    this.closest(".address-group").querySelector(".quan");
                  const phuongSelect =
                    this.closest(".address-group").querySelector(".phuong");

                  // Reset quận/huyện và xã/phường khi tỉnh/thành thay đổi
                  quanSelect.innerHTML =
                    '<option value="0">Quận Huyện</option>';
                  phuongSelect.innerHTML =
                    '<option value="0">Phường Xã</option>';

                  // Đổ dữ liệu quận/huyện vào select tương ứng
                  data_quan.data.forEach((val_quan) => {
                    const option = document.createElement("option");
                    option.setAttribute("quanId", val_quan.id);
                    option.value = val_quan.full_name + "," + val_quan.id;
                    option.textContent = val_quan.full_name;
                    quanSelect.appendChild(option);
                  });

                  // Xử lý khi người dùng chọn quận/huyện
                  quanSelect.addEventListener("change", function () {
                    const selectedOption = this.options[this.selectedIndex];
                    const idquan = selectedOption.getAttribute("quanId");

                    // Lấy phường xã cho quận/huyện đã chọn
                    fetch(`https://esgoo.net/api-tinhthanh/3/${idquan}.htm`)
                      .then((response) => response.json())
                      .then((data_phuong) => {
                        if (data_phuong.error === 0) {
                          // Reset xã/phường khi quận/huyện thay đổi
                          phuongSelect.innerHTML =
                            '<option value="0">Phường Xã</option>';

                          // Đổ dữ liệu phường/xã vào select tương ứng
                          data_phuong.data.forEach((val_phuong) => {
                            const option = document.createElement("option");
                            option.value =
                              val_phuong.full_name + "," + val_phuong.id;

                            option.textContent = val_phuong.full_name;
                            phuongSelect.appendChild(option);
                          });
                        }
                      });
                  });
                }
              });
          });
        });
      }
    });
});

//  lựa chọn hình ảnh
const listThumb = document.querySelectorAll(".prod-preview__thumb-img");

if (listThumb) {
  listThumb.forEach((thum) => {
    thum.addEventListener("click", function () {
      listThumb.forEach((thumb) =>
        thumb.classList.remove("prod-preview__thumb-img--current")
      );

      thum.classList.add("prod-preview__thumb-img--current");
      const parent = thum.parentElement.parentElement;
      const newSrc = thum.getAttribute("src");
      const parentPre = parent.querySelector(
        ".prod-preview__list .prod-preview__item .prod-preview__img"
      );
      parentPre.setAttribute("src", newSrc);
    });
  });
}

//  quản lí sự kiện tăng giảm trang detail

let quantity = 1;
// Lấy các phần tử cần thiết
const quantityDisplay = document.getElementById("quantity");
const increaseBtn = document.getElementById("increase");
const decreaseBtn = document.getElementById("decrease");
const quantitySubmit = document.getElementById("quantity-submit");

// Hàm cập nhật hiển thị số lượng
function updateQuantityDisplay() {
  quantityDisplay.textContent = quantity;
  quantitySubmit.value = quantity;
}

// Sự kiện cho nút tăng
if (increaseBtn)
  increaseBtn.addEventListener("click", () => {
    quantity++;

    updateQuantityDisplay();
  });

// Sự kiện cho nút giảm
if (decreaseBtn)
  decreaseBtn.addEventListener("click", () => {
    if (quantity > 1) {
      // Đảm bảo số lượng không giảm dưới 1
      quantity--;
    }
    updateQuantityDisplay();
  });

document.addEventListener("DOMContentLoaded", function () {
  const queryString = window.location.search;
  const params = new URLSearchParams(queryString);

  // Lấy giá trị của tham số 'sort'
  const sort = params.get("sort");

  // Lấy giá trị của tham số 'price'
  const price = params.get("price");

  // Lấy tất cả các checkbox có class là 'form-check-input'
  const sortProducts = document.querySelectorAll(".form-check-input");

  // Duyệt qua từng checkbox
  sortProducts.forEach((pr) => {
    // Kiểm tra xem giá trị của checkbox có bằng giá trị 'sort' hoặc 'price' không
    if (pr.value === sort || pr.value === price) {
      pr.checked = true; // Đánh dấu checkbox là được chọn
    }
  });

  const pageLinks = document.querySelectorAll(".page-link");
  const url = new URL(window.location.href);
  let currentPage = parseInt(url.searchParams.get("page")) || 1; // Lấy trang hiện tại từ URL, mặc định là 1 nếu không có

  pageLinks.forEach((page) => {
    const statusPage = page.getAttribute("aria-label");

    // Xác định hành động cho nút "Previous" và "Next" hoặc trang cụ thể
    if (statusPage === "Previous") {
      // Nếu là nút "Previous", giảm số trang đi 1
      page.href = url.toString();
      if (currentPage > 1) {
        url.searchParams.set("page", currentPage - 1);
        page.href = url.toString();
      }
    } else if (statusPage === "Next") {
      // Nếu là nút "Next", tăng số trang thêm 1
      url.searchParams.set("page", currentPage + 1);
      page.href = url.toString();
    } else {
      // Nếu là trang cụ thể, kiểm tra số trang từ textContent và thiết lập URL
      const pageNumber = parseInt(page.textContent.trim());
      if (!isNaN(pageNumber)) {
        url.searchParams.set("page", pageNumber);
        page.href = url.toString();
      }
    }
  });
});
// phân trang

// document.addEventListener("DOMContentLoaded", function () {
//   // Lấy trang hiện tại từ URL
//   const urlParams = new URLSearchParams(window.location.search);
//   let currentPage = parseInt(urlParams.get("page")) || 1; // Mặc định là 1 nếu không có tham số

//   // Lấy phần tử danh sách phân trang
//   const paginationList = document.getElementById("pagination-links");

//   // Kiểm tra xem nút Next đã tồn tại chưa
//   const pageList = paginationList.getElementsByClassName("page-link") ;
//   const nextExists = Array.from(
//     pageList
//   ).some((link) => link.textContent.includes("»"));

//   // Nếu trang hiện tại là 1 và nút Next chưa tồn tại, thêm nút Next
//   if (currentPage === 1 && !nextExists) {
//     const nextItem = document.createElement("li");
//     nextItem.className = "page-item";
//     nextItem.innerHTML = `
//       <a class="page-link" href="/?page=${currentPage + 1}" aria-label="Next">
//         <span aria-hidden="true">»</span>
//       </a>
//     `;
//     paginationList.appendChild(nextItem);
//   }
// });

document.addEventListener("DOMContentLoaded", function () {
  const formatDate = document.querySelectorAll(".format-date");

  formatDate.forEach((dateElement) => {
    const textDate = dateElement.textContent; // Lấy nội dung văn bản

    // Sử dụng Moment.js để định dạng lại ngày
    const formattedDate = moment(textDate).utc().format("HH:mm DD/MM/YYYY");

    // Cập nhật nội dung văn bản của phần tử
    dateElement.textContent = formattedDate;
  });
});

const btnReset = document.querySelectorAll(".btn-reset");

if (btnReset) {
  const currentImg = document.getElementById("img-preview");
  const imgSrc = currentImg == null ? "" : currentImg.src;
  btnReset.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      const form = btn.closest("form");
      if (form) {
        // Reset tất cả các input trong form
        currentImg.src = imgSrc;
        form.reset();
      }
    });
  });

  // preview avatar
  const fileInput = document.getElementById("avatarImg");
  const previewImage = document.getElementById("img-preview");
  if (fileInput && previewImage) {
    fileInput.addEventListener("change", (event) => {
      const file = event.target.files[0];

      if (file) {
        // Tạo URL để hiển thị ảnh
        const reader = new FileReader();
        reader.onload = (e) => {
          previewImage.src = e.target.result;
          previewImage.style.display = "block";
        };
        reader.readAsDataURL(file);
      } else {
        // Nếu không có file, ẩn preview
        previewImage.src = "";
        previewImage.style.display = "none";
      }
    });
  }
}

const togglePasswords = document.querySelectorAll(".togglePassword");

if (togglePasswords) {
  togglePasswords.forEach((elemet) => {
    elemet.addEventListener("click", function () {
      const passwordField = elemet.parentElement.querySelector(".pass-input");
      console.log(passwordField);

      if (passwordField.type === "password") {
        passwordField.type = "text";
        elemet.classList.remove("fa-eye");
        elemet.classList.add("fa-eye-slash");
      } else {
        passwordField.type = "password";
        elemet.classList.remove("fa-eye-slash");
        elemet.classList.add("fa-eye");
      }
    });
  });
}


