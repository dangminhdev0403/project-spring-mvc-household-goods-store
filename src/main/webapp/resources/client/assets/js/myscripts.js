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
function renderPagin(element, currentPage, totalPage) {
  element.innerHTML = ""; // Xóa nội dung cũ

  let pagesToShow = [];

  if (totalPage <= 1) return; // Không cần phân trang nếu chỉ có 1 trang

  // Hiển thị trang đầu tiên
  if (currentPage > 3) {
    pagesToShow.push(1);
    if (currentPage > 4) pagesToShow.push("...");
  }

  // Hiển thị các trang xung quanh trang hiện tại
  const startPage = Math.max(1, currentPage - 2);
  const endPage = Math.min(totalPage, currentPage + 2);
  for (let i = startPage; i <= endPage; i++) {
    pagesToShow.push(i);
  }

  // Hiển thị trang cuối cùng
  if (currentPage < totalPage - 2) {
    if (currentPage < totalPage - 3) pagesToShow.push("...");
    pagesToShow.push(totalPage);
  }

  // Tạo các liên kết trang
  pagesToShow.forEach((page) => {
    const pageElement = document.createElement("a");
    pageElement.classList.add("page-link");

    if (page === "...") {
      pageElement.textContent = "...";
      pageElement.classList.add("ellipsis");
      pageElement.href = "#"; // Không làm gì khi nhấp vào "..."
    } else {
      pageElement.textContent = page;

      // Tạo URL với tham số ?page
      const currentUrl = new URL(window.location.href);
      currentUrl.searchParams.set("page", page);
      pageElement.href = currentUrl.toString();

      if (page === currentPage) {
        pageElement.classList.add("active"); // Đánh dấu trang hiện tại
      }

      // Thêm sự kiện khi nhấn vào trang
      pageElement.addEventListener("click", (event) => {
        event.preventDefault(); // Ngăn tải lại trang
        renderPagin(element, page, totalPage); // Gọi lại để render trang mới
      });
    }

    element.appendChild(pageElement);
  });
}

document.addEventListener("DOMContentLoaded", function () {
  const paginations = document.querySelectorAll(".pagination"); // Lấy tất cả phần tử phân trang

  paginations.forEach((pagination) => {
    const totalPage = parseInt(pagination.getAttribute("data-total-page"));
    const currentPage = parseInt(
      pagination.querySelector(".page-link.active").textContent
    );

    renderPagin(pagination, currentPage, totalPage); // Render phân trang

    const pageLinks = pagination.querySelectorAll(".page-link");
    if (pageLinks) {
      pageLinks.forEach((page) => {
        page.addEventListener("click", function (e) {
          e.preventDefault();
          let hrefValue = page.href;
          window.location.href = hrefValue;
        });
      });
    }
  });
});

// location

function getData(url, selectElement, text, idLocation) {
  fetch(url)
    .then((response) => response.json())

    .then((data) => {
      populateSelect(data, selectElement, text, idLocation);
    })

    .catch((error) => console.log(error));
}

// tạo danh sách tỉnh
function populateSelect(data, selectElement, text, idLocation) {
  // Xóa các tùy chọn hiện có (nếu có)
  if (selectElement) {
    selectElement.innerHTML = "";

    const defaultOption = document.createElement("option");
    defaultOption.value = "";
    defaultOption.textContent = text; // Bỏ khoảng cách thừa ở đây
    selectElement.appendChild(defaultOption);

    // Thêm dữ liệu vào <select>
    if (!Array.isArray(data)) {
      const arrayData = Object.values(data);

      arrayData.forEach((item) => {
        const option = document.createElement("option");
        option.value = item.id; // Sử dụng mã tỉnh làm giá trị
        if (option.value == idLocation) {
          option.selected = true;
        }
        option.textContent = item.name; // Hiển thị tên tỉnh
        selectElement.appendChild(option);
      });
    } else {
      data.forEach((item) => {
        const option = document.createElement("option");
        option.value = item.id; // Sử dụng mã tỉnh làm giá trị
        if (option.value == idLocation) {
          option.selected = true;
        }
        option.textContent = item.name; // Hiển thị tên tỉnh
        selectElement.appendChild(option);
      });
    }
  }
}
function getDistricts(e, baseUrl) {
  let text = "Chọn Quận/Huyện";

  const quanSelect = e.target
    .closest(".form__group")
    ?.querySelector("select.quan");

  e.preventDefault();
  idTinh = e.target.value;
  let urlDistricts = baseUrl + "/districts/" + idTinh;

  getData(urlDistricts, quanSelect, text);
}
function getWard(e, baseUrl) {
  let text = "Chọn Xã/Phường";

  const xaSelect = e.target
    .closest(".form__group")
    ?.querySelector("select.phuong");

  e.preventDefault();
  idHuyen = e.target.value;
  console.log(idHuyen);
  let urlDistricts = baseUrl + "/wards/" + idHuyen;

  getData(urlDistricts, xaSelect, text);
}
document.addEventListener("DOMContentLoaded", function () {
  const baseUrl = window.location.origin;
  urlProvinces = baseUrl + "/provinces";

  const tinhSelects = document.querySelectorAll("select.tinh");
  const quanSelects = document.querySelectorAll("select.quan");
  const phuongSelects = document.querySelectorAll("select.phuong");

  if (tinhSelects) {
    tinhSelects.forEach((select) => {
      idTinh = select.getAttribute("data-city-id");

      getData(urlProvinces, select, " Tỉnh/Thành phố", idTinh);
      select.addEventListener("change", (e) => getDistricts(e, baseUrl));

      const selectHuyen = select.parentElement.querySelector("select.quan");
      if (selectHuyen) {
        selectHuyen.addEventListener("change", (e) => getWard(e, baseUrl));
      }
    });
  }

  if (quanSelects) {
    quanSelects.forEach((select) => {
      let urlDistricts = baseUrl + "/districts/" + idTinh;
      idQuan = select.getAttribute("data-district-id");

      getData(urlDistricts, select, "Quận/Huyện", idQuan);
    });
  }
  if (phuongSelects) {
    phuongSelects.forEach((select) => {
      let urlWards = baseUrl + "/wards/" + idQuan;
      idXa = select.getAttribute("data-ward-id");

      getData(urlWards, select, "Quận/Huyện", idXa);
    });
  }
});



document.addEventListener("DOMContentLoaded", function () {
  const sellectAll = document.querySelector('.check-all-box');
  if(sellectAll){
    const selects = document.querySelectorAll('input.checkbox');
    const count = selects.length;  // Đếm số phần tử trong NodeList
    if(count === 0){
      sellectAll.classList.add('d-none');
    }
  }
})

