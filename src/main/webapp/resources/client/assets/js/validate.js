
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
    email: { message: " không hợp lệ" },
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
      pattern: /^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$/,
      message:
        "Mật khẩu phải có ít nhất 6 ký tự, Một chữ cái hoa và một chữ số",
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

const emailConstraints ={
  email: {
    email: { message: " không hợp lệ" },
  }
}

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


document.addEventListener('DOMContentLoaded', function() {
  const btnResetPass = document.querySelector('.email-reset');
  if (btnResetPass) {
    console.log(btnResetPass);
    btnResetPass.addEventListener('input', function(e) {
      e.preventDefault();
      
      const data ={
        email: e.target.value 
      }

      const errors = validate(data, emailConstraints);

      document.querySelectorAll(".form__error").forEach((el) => el.remove());
      document
        .querySelectorAll(".form__group")
        .forEach((el) => el.classList.remove("invalid"));

        if(errors){
          displayError2(btnResetPass, errors['email']);

        }

    });


  }

  
    
  

});
// Hàm hiển thị lỗi
function displayError(input, message) {
  const parent = input.closest(".form__group");
  parent.classList.add("invalid");

  const spanError = document.createElement("span");
  spanError.classList.add("form__error", "d-block");

  let textExcess = ["Password", "Confirm password"];
if(textExcess)
 {
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

