function alert(notice, message, formElement) {
  swal({
    title: notice,
    text: message,
    icon: "warning", // Sử dụng "icon" thay vì "type"
    buttons: {
      cancel: {
        text: "Huỷ bỏ", // Tùy chỉnh nút "Huỷ bỏ"
        visible: true,
        className: "btn btn-danger",
      },
      confirm: {
        text: "Đồng ý",
        className: "btn btn-success",
      },
    },
    reverseButtons: false,
  }).then((willDelete) => {
    if (willDelete) {
      formElement.submit();
      showLoading();
    } else {
    }
  });
}

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

const loginConstraints = {
  email: {
    presence: { message: "Vui lòng nhập email" },
    email: { message: " không hợp lệ, xoá khoảng trống sau email" },
  },
  password: {
    presence: { message: "Vui lòng nhập mật khẩu" },
    length: { minimum: 6, message: "Mật khẩu phải có ít nhất 6 ký tự" },
  },
};

const resConstraints = {
  email: {
    presence: { message: "Vui lòng nhập email" },
    email: { message: " không hợp lệ" },
  },
  password: {
    presence: { message: "Vui lòng nhập mật khẩu" },
    length: { minimum: 6, message: "Mật khẩu phải có ít nhất 6 ký tự" },
    format: {
      pattern: /^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{6,}$/,
      message:
   
        "Mật khẩu phải có ít nhất 6 ký tự, Một chữ in cái hoa ,một chữ số,một ký tự đặc biệt",

    },
  },
  confirmPassword: {
    presence: { message: "Vui lòng xác nhận mật khẩu" },
    equality: {
      attribute: "password",
      message: "Mật khẩu xác nhận không khớp với mật khẩu",
    },
  },
};

const emailConstraints = {
  email: {
    email: { message: " không hợp lệ" },
  },
};

const formLogin = document.querySelector("#form-login");

if (formLogin) {
  formLogin.addEventListener("submit", function validation(e) {
    e.preventDefault();

    const email = document.getElementById("email");
    const password = document.getElementById("password");

    const formData = {
      email: email.value,
      password: password.value,
    };

    // Xóa thông báo lỗi cũ
    document.querySelectorAll(".form__error").forEach((el) => el.remove());
    document
      .querySelectorAll(".form__group")
      .forEach((el) => el.classList.remove("invalid"));

    // Kiểm tra thủ công sự hiện diện của trường
    if (!formData.email) {
      displayError(email, "Vui lòng nhập email");
    }

    if (!formData.password) {
      displayError(password, "Vui lòng nhập mật khẩu");
    }

    if (formData.email && formData.password) {
      const errors = validate(formData, loginConstraints);

      if (errors) {
        Object.keys(errors).forEach((key) => {
          const input = document.getElementById(key);
          displayError(input, errors[key][0]);
        });
      } else {
        formLogin.submit();
        showLoading();
      }
    }
  });
}

const formRegister = document.querySelector("#form-register");

if (formRegister) {
  formRegister.addEventListener("submit", function (e) {
    e.preventDefault();

    const lastName = document.querySelector("#restLast");
    const firtsName = document.querySelector("#resName");
    const email = document.querySelector("#email");
    const password = document.querySelector("#password");
    const confirmPassword = document.querySelector("#confirmPassword");

    const formData = {
      lastName: lastName.value,
      firtsName: firtsName.value,
      email: email.value,
      password: password.value,
      confirmPassword: confirmPassword.value,
    };

    document.querySelectorAll(".form__error").forEach((el) => el.remove());
    document
      .querySelectorAll(".form__group")
      .forEach((el) => el.classList.remove("invalid"));

    const fields = [
      { field: "email", message: "Vui lòng nhập email", inputElement: email },
      {
        field: "password",
        message: "Vui lòng nhập mật khẩu",
        inputElement: password,
      },
      {
        field: "lastName",
        message: "Vui lòng nhập Họ",
        inputElement: lastName,
      },
      {
        field: "firtsName",
        message: "Vui lòng nhập tên",
        inputElement: firtsName,
      },
      {
        field: "confirmPassword",
        message: "Vui lòng xác nhận mật khẩu",
        inputElement: confirmPassword,
      },
    ];

    fields.forEach(({ field, message, inputElement }) => {
      if (!formData[field]) {
        displayError(inputElement, message);
      }
    });

    if (Object.values(formData).every((value) => value)) {
      const errors = validate(formData, resConstraints);

      if (errors) {
        Object.keys(errors).forEach((key) => {
          const input = document.getElementById(key);
          displayError(input, errors[key][0]);
        });
      } else {
        formRegister.submit();
        showLoading();
      }
    }
  });
}

document.addEventListener("DOMContentLoaded", function () {
  const btnResetPass = document.querySelector(".email-reset");
  if (btnResetPass) {
    btnResetPass.addEventListener("input", function (e) {
      e.preventDefault();

      const data = {
        email: e.target.value,
      };

      const errors = validate(data, emailConstraints);

      document.querySelectorAll(".form__error").forEach((el) => el.remove());
      document
        .querySelectorAll(".form__group")
        .forEach((el) => el.classList.remove("invalid"));

      if (errors) {
        displayError2(btnResetPass, errors["email"]);
      }
    });
  }
});

const payNowConstraints = {
  email: {
    presence: { allowEmpty: false, message: "Vui lòng nhập email" },
    email: { message: "Email không hợp lệ" },
  },
  receiverName: {
    presence: { allowEmpty: false, message: "Vui lòng nhập Tên người nhận" },
    length: { minimum: 2, message: "Tên người nhận phải có ít nhất 2 ký tự" },
  },
  receiverPhone: {
    presence: { allowEmpty: false, message: "Vui lòng nhập SDT người nhận" },

    format: {
      pattern: /^[0-9]{10,11}$/, // Chỉ chấp nhận số điện thoại có 10 hoặc 11 chữ số
      message: "SDT người nhận phải là số có 10 hoặc 11 số",
    },
  },
  address: {
    presence: {
      allowEmpty: false,
      message: "Vui lòng nhập địa chỉ",
    },
  },
};

const valPaynow = (e) => {
  e.preventDefault();
  document.querySelectorAll(".form__error").forEach((el) => el.remove());
  document
    .querySelectorAll(".form__group")
    .forEach((el) => el.classList.remove("invalid"));

  const email = document.getElementById("email");
  const receiverName = document.getElementById("receiverName");
  const receiverPhone = document.getElementById("receiverPhone");
  const address = document.getElementById("address");

  const emailValid = validateField(email, payNowConstraints.email);
  const nameValid = validateField(receiverName, payNowConstraints.receiverName);
  const phoneValid = validateField(
    receiverPhone,
    payNowConstraints.receiverPhone
  );
  const addressValid = validateField(address, payNowConstraints.address);

  if (emailValid && nameValid && phoneValid && addressValid) {
    const notice = "Xác nhận đặt hàng";
    const message = "Bạn có muốn đặt hàng?";
    const form = document.getElementById("form-pay-now");
    alert(notice, message, form);
  }
};
const btnPay = document.querySelector("#pay-now");
if (btnPay) {
  btnPay.addEventListener("click", (e) => valPaynow(e));
}

const validateField = (field, constraints) => {
  if (field != null) {
    const errors = validate.single(field.value, constraints);
    if (errors) {
      displayError(field, errors[0]);
      return false;
    }
  }
  return true;

};

const passResetConstraints = {
  password: {
    presence: {
      allowEmpty: false,
      message: "Vui lòng nhập mật khẩu",
    },
    format: {
      pattern: /^(?=.*[A-Z])(?=.*\d)[A-Za-z\d\W_]{6,}$/,

      message:
        "Mật khẩu phải có ít nhất 6 ký tự, Một chữ in cái hoa ,một chữ số,một ký tự đặc biệt"
    },
  },
  confirmPassword: {
    presence: { allowEmpty: false, message: "Vui lòng xác nhận mật khẩu" },
  },
};

const btnReset2 = document.getElementById("reset-password");
if (btnReset2) {
  btnReset2.addEventListener("click", function (e) {
    e.preventDefault();
    document.querySelectorAll(".form__error").forEach((el) => el.remove());
    document
      .querySelectorAll(".form__group")
      .forEach((el) => el.classList.remove("invalid"));
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");

    const passValid = validateField(password, passResetConstraints.password);
    const confirmPasswordValid = validateField(
      confirmPassword,
      passResetConstraints.confirmPassword
    );
    if (passValid && confirmPasswordValid) {
      if (password.value.trim() !== confirmPassword.value.trim()) {
        displayError(confirmPassword, "Mật khẩu không trùng khớp");
      } else {
        const notice = "Xác nhận thay đổi";
        const message = "Bạn có muốn thay đổi mật khẩu?";
        const form = document.getElementById("change-password");
        alert(notice, message, form);
      }
    }
  });
}

const addressConstraints = {
  receiverName: {
    presence: { allowEmpty: false, message: "Vui lòng nhập tên" },
  },
  receiverPhone: {
    presence: { allowEmpty: false, message: "Vui lòng nhập số điện thoại" },
    format: {
      pattern: /^[0-9]{10,11}$/, // Chỉ chấp nhận số điện thoại có 10 hoặc 11 chữ số
      message: "SDT phải là số có 10 hoặc 11 số",
    },
  },
  address: {
    presence: { allowEmpty: false, message: "Vui lòng nhập địa chỉ chi tiết" },
  },
};
const addresses = document.querySelectorAll(".form.address");
if (addresses) {
  addresses.forEach((form) => {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      document.querySelectorAll(".form__error").forEach((el) => el.remove());
      document
        .querySelectorAll(".form__group")
        .forEach((el) => el.classList.remove("invalid"));

      const receiverName = form.querySelector(".receiverName");
      const receiverPhone = form.querySelector(".receiverPhone");
      const address = form.querySelector(".address");
      const tinh = form.querySelector("select.tinh");

      const quan = form.querySelector("select.quan");
      const phuong = form.querySelector("select.phuong");
      let isValid = true;

      const receiverNameValid = validateField(
        receiverName,
        addressConstraints.receiverName
      );
      const receiverPhoneValid = validateField(
        receiverPhone,
        addressConstraints.receiverPhone
      );
      const addressValid = validateField(address, addressConstraints.address);

      if (receiverNameValid && addressValid && receiverPhoneValid) {
        if (tinh.value === "null" ) {
          displayError(tinh, "chọn Tỉnh/Thành phố!");

          isValid = false;
        }

        if (quan.value === "null") {
          displayError(quan, "chọn Quận/Huyện!");

          isValid = false;
        }

        if (phuong.value === "null") {
          displayError(phuong, "chọn Phường/Xã!");

          isValid = false;
        }

        if (isValid === true) {
          form.submit();
          showLoading();
        }
      }
    });
  });
}

// Hàm hiển thị lỗi
function displayError(input, message) {
  const parent = input.closest(".form__group");
  parent.classList.add("invalid");

  const spanError = document.createElement("span");
  spanError.classList.add("form__error", "d-block");

  let textExcess = ["Password", "Confirm password"];
  if (textExcess) {
    textExcess.forEach((text) => {
      if (message.includes(text)) {
        message = message.replace(new RegExp(text, "gi"), "").trim(); // Loại bỏ từ "Password" (không phân biệt chữ hoa/thường)
      }
    });
  }

  if (message.includes(",")) {
    // Nếu có dấu phẩy, chia chuỗi thành các phần tử li
    let messageParts = message
      .split(",")
      .map((part) => `<li style =" margin-top: 2rem;">${part.trim()}</li>`)
      .join("");
    message = `<ul>${messageParts}</ul>`;
  }

  spanError.innerHTML = message; // Sử dụng innerHTML để chèn HTML
  parent.appendChild(spanError);
}

// Hàm hiển thị lỗi 2
function displayError2(input, message) {
  const parent = input.closest(".form__group");
  parent.classList.add("invalid");

  const spanError = document.createElement("span");
  spanError.classList.add("form__error", "d-block");

  spanError.innerHTML = message; // Sử dụng innerHTML để chèn HTML
  parent.appendChild(spanError);
}
