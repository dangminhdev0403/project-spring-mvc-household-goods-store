const formUser = document.querySelectorAll(".form-user");

document.addEventListener("DOMContentLoaded", function () {
  if (formUser) {
    formUser.forEach((form) => {
      form.addEventListener("submit", function (e) {
        e.preventDefault();
        const email2 = form.querySelector("#email2");
        const name = form.querySelector("#fullname");
        const password = form.querySelector("#password");
        const phone = form.querySelector("#phone");
        const data = {
          email2: email2.value,
          name: name.value,
          phone: phone.value,
          password: password.value,
        };

        document.querySelectorAll(".form__error").forEach((el) => el.remove());
        document
          .querySelectorAll(".form__group")
          .forEach((el) => el.classList.remove("has-error"));

        const fields = [
          {
            field: "name",
            message: "Vui lòng nhập tên",
            inputElement: name,
          },
          {
            field: "email2",
            message: "Vui lòng nhập email",
            inputElement: email2,
          },
          {
            field: "password",
            message: "Vui lòng nhập mật khẩu",
            inputElement: password,
          },
          {
            field: "phone",
            message: "Vui lòng nhập sdt",
            inputElement: phone,
          },
        ];

 let isCheck = true ;
        fields.forEach(({ field, message, inputElement }) => {
          if (!data[field]) {
            isCheck = false ;
            displayError(inputElement, message);
          }
        });

        if(isCheck === true){
          form.submit();
        }
      });
    });
  }
});

function displayError(input, message) {
  const parent = input.closest(".form-group");
  parent.classList.add("has-error");
  const spanError = document.createElement("span");
  spanError.classList.add("form__error", "d-block","text-danger");

  spanError.innerHTML = message; // Sử dụng innerHTML để chèn HTML
  parent.appendChild(spanError);
}
