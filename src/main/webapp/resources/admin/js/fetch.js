function updateUIAfterAction(url) {
  const element = document.querySelector(`a[href='${url}']`);

  if (element) {
    const rowElement = element.closest("tr"); // Lấy phần tử <tr> chứa liên kết
    const statusCell = rowElement.querySelector(".status"); // Giả sử bạn có cột trạng thái người dùng

    if (rowElement && statusCell) {
      if (url.includes("delete")) {
        rowElement.remove(); // Xoá phần tử <tr> khỏi DOM
      }
      if (url.includes("lock")) {
        const icon = element.querySelector("i.fas");
        icon.classList.remove("fa-lock");
        icon.classList.add("fa-lock-open");
        element.setAttribute("href", url.replace("lock", "unlock")); // Thay đổi URL thành "unlock"
        element.classList.remove("is-lock");
        element.classList.add("is-unlock");
        statusCell.textContent = "Tạm khoá"; // Cập nhật trạng thái khoá
      }

      if (url.includes("unlock")) {
        const icon = element.querySelector("i.fas");
        icon.classList.add("fa-lock");
        icon.classList.remove("fa-lock-open");
        element.setAttribute("href", url.replace("unlock", "lock")); // Thay đổi URL thành "unlock"
        element.classList.remove("is-unlock");
        element.classList.add("is-lock");
        statusCell.textContent = "Đang hoạt động"; // Cập nhật trạng thái mở khoá
      }
    }
  }
}
const csrfToken = document
  .querySelector('meta[name="_csrf"]')
  .getAttribute("content");

function alertWithFetch(e, title, message, method) {
  e.preventDefault();
  let url = e.currentTarget.getAttribute("href");
  console.log(url);

  swal({
    title: title,
    text: message,
    icon: "warning",
    buttons: {
      cancel: {
        text: "Huỷ bỏ",
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
      fetch(url, {
        method: method,
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-TOKEN": csrfToken, // Thêm CSRF token vào header
        },
      })
        .then((res) => {
          if (res.ok) {
            const contentType = res.headers.get("Content-Type");
            if (contentType && contentType.includes("application/json")) {
              return res.json(); // Phản hồi là JSON
            } else {
              throw new Error("Phản hồi không phải JSON.");
            }
          } else {
            throw new Error("Có lỗi xảy ra khi xoá người dùng.");
          }
        })
        .then((data) => {

          updateUIAfterAction(url);
          swal("thành công", data.message, "success");
        })
        .catch((err) => {
          swal("Lỗi", err, "error");
        });
    }
  });
}

const deleteElements = document.querySelectorAll(".is-delete");
if (deleteElements) {
  let title = "Bạn có chắc muốn xoá?";
  let message = "Dữ liệu sẽ bị xoá vĩnh viễn";
  deleteElements.forEach((element) => {
    element.addEventListener("click", function (e) {
      alertWithFetch(e, title, message, "GET");
    });
  });
}

const lockElements = document.querySelectorAll(".is-lock");
if (lockElements) {
  let title = "Bạn có chắc muốn khoá tài khoản này?";
  let message = "Tài khoản này sẽ bị tạm khoá";
  lockElements.forEach((element) => {
    element.addEventListener("click", function (e) {
      alertWithFetch(e, title, message, "GET");
    });
  });
}

const unLockElements = document.querySelectorAll(".is-unlock");
if (unLockElements) {
  let title = "Bạn có chắc muốn mở khoá tài khoả này?";
  let message = "Tài khoản này sẽ được mở khoá";
  unLockElements.forEach((element) => {
    element.addEventListener("click", function (e) {
      alertWithFetch(e, title, message, "GET");
    });
  });
}
