


function addItem() {
  const dropdown = document.getElementById("dropdown__list");
  const colElements = dropdown.getElementsByClassName('col');
if( colElements ===null || colElements.length < 3){
  const src = document.querySelector(".prod-preview__img").src;
  const name = document.querySelector(".prod-info__heading").textContent;
  const price = document.querySelector(".prod-info__total-price").innerText;

  const item = document.createElement("div");
  item.classList.add("col");
  item.innerHTML = `
  <article class="cart-preview-item">
    <div class="cart-preview-item__img-wrap">
      <img src="${src}" alt="" class="${name}">
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
        addItem();
        qtyProduct.textContent = parseInt(qtyProduct.textContent) + 1;

        swal("Thành công", response.data, "success");
      } else {
        swal("Thành công", "Thêm giỏ hàng thành công", "success");
      }
    })
    .catch((error) => {
      console.error("Error:", error);
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
