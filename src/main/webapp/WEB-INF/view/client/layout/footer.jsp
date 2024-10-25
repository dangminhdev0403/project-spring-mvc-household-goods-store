<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<footer id="footer" class="footer">
    <div class="container">
        <div class="footer__row">
            <!-- Footer column 1 -->
            <div class="footer__col">
                <!-- Logo -->
                <a href="/client" class="logo footer__logo">
                    <img src="/client/assets/icons/logo.svg" alt="grocerymart" class="logo__img" />
                    <h1 class="logo__title">grocerymart</h1>
                </a>
                <p class="footer__desc">
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Quam, maxime et veniam eligendi rem
                    voluptatibus.
                </p>
    
                <p class="footer__help-text">Receive product news and updates.</p>
                <form action="" class="footer__form">
                    <input type="text" class="footer__input" placeholder="Email address" />
                    <button class="btn btn--primary">SEND</button>
                </form>
            </div>
    
            <!-- Footer column 2 -->
            <div class="footer__col">
                <h3 class="footer__heading">Shop</h3>
                <ul class="footer__list">
                    <li>
                        <a href="#!" class="footer__link">All Departments</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Fashion Deals</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Electronics Discounts</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Home & Living Specials</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Beauty Bargains</a>
                    </li>
                </ul>
            </div>
    
            <!-- Footer column 3 -->
            <div class="footer__col">
                <h3 class="footer__heading">Support</h3>
                <ul class="footer__list">
                    <li>
                        <a href="#!" class="footer__link">Store locator</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Order status</a>
                    </li>
                </ul>
            </div>
    
            <!-- Footer column 4 -->
            <div class="footer__col">
                <h3 class="footer__heading">Company</h3>
                <ul class="footer__list">
                    <li>
                        <a href="#!" class="footer__link">Customer Service</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Terms of Use</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Privacy</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Careers</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">About</a>
                    </li>
                    <li>
                        <a href="#!" class="footer__link">Affiliates</a>
                    </li>
                </ul>
            </div>
    
            <!-- Footer column 5 -->
            <div class="footer__col">
                <h3 class="footer__heading">Contact</h3>
                <ul class="footer__list">
                    <li>
                        <p class="footer__label">Email</p>
                        <a href="mailto:contact@grocerymart.com" class="footer__link"> contact@grocerymart.com </a>
                    </li>
                    <li>
                        <p class="footer__label">Hotline</p>
                        <a href="tel:18008888" class="footer__link">18008888</a>
                    </li>
                    <li>
                        <p class="footer__label">Address</p>
                        <p class="footer__text">
                            No. 11D, Lot A10, Nam Trung Yen urban area, Yen Hoa Ward, Cau Giay District, City. Hanoi
                        </p>
                    </li>
                    <li>
                        <p class="footer__label">Hours</p>
                        <p class="footer__text">M - F 08:00am - 06:00pm</p>
                    </li>
                </ul>
            </div>
        </div>
        <div class="footer__bottom">
            <p class="footer__copyright">© 2010 - 2025 Grocery Mart. All rights reserved.</p>
    
            <div class="footer__socials">
                <a href="#!" class="footer__social-link footer__social-link--facebook">
                    <img src="/client/assets/icons/facebook.svg" alt="" class="footer__social-icon" />
                </a>
                <a href="#!" class="footer__social-link footer__social-link--youtube">
                    <img src="/client/assets/icons/youtube.svg" alt="" class="footer__social-icon" />
                </a>
                <a href="#!" class="footer__social-link footer__social-link--tiktok">
                    <img src="/client/assets/icons/tiktok.svg" alt="" class="footer__social-icon" />
                </a>
                <a href="#!" class="footer__social-link footer__social-link--twitter">
                    <img src="/client/assets/icons/twitter.svg" alt="" class="footer__social-icon" />
                </a>
                <a href="#!" class="footer__social-link footer__social-link--linkedin">
                    <img src="/client/assets/icons/linkedin.svg" alt="" class="footer__social-icon" />
                </a>
            </div>
        </div>
    </div>
    
</footer>

<!-- Thêm thẻ <p> để hiển thị thông điệp -->
    <p id="mode-message"></p>

    <script>
    let switchBtn = document.querySelector("#switch-theme-btn");
    let spanMode = document.querySelector("#switch-theme-btn span");
    let modeMessage = document.getElementById("mode-message"); // Lấy thẻ <p>
    
    function updateModeMessage() {
        const isDarkMode = document.querySelector("html").classList.contains("dark");
        
        // Cập nhật nội dung cho thẻ <p> dựa trên giao diện
        if (isDarkMode) {
            modeMessage.textContent = "Giao diện tối";
        } else {
            modeMessage.textContent = "Giao diện sáng";
        }
    }
    
    if (switchBtn) {
        switchBtn.onclick = function () {
            const isDark = localStorage.dark === "true";
            document.querySelector("html").classList.toggle("dark", !isDark);
            localStorage.setItem("dark", !isDark);
            
            // Cập nhật textContent cho span
            spanMode.textContent = isDark ? "Giao diện tối" : "Giao diện sáng";
    
            // Cập nhật thông điệp
            updateModeMessage();
        };
    
        // Khởi tạo nội dung cho span dựa trên localStorage
        const isDark = localStorage.dark === "true";
        spanMode.textContent = isDark ? "Giao diện sáng" : "Giao diện tối";
    
        // Cập nhật thông điệp ban đầu
        updateModeMessage();
    }
    </script>
<!-- Thêm thẻ <p> để hiển thị thông điệp -->

    
        
    
</body>
<!-- Thêm thẻ <p> để hiển thị thông điệp -->
    <script>
        function formatNumber(num) {
          if (typeof num !== 'number' || isNaN(num)) {
            return '0,00'; 
          }
      
          const formatter = new Intl.NumberFormat('pt-BR', {
            minimumFractionDigits: 0,
            maximumFractionDigits: 3,
          });
      
          let formattedNumber = formatter.format(num);
          let [integerPart, decimalPart] = formattedNumber.split(',');
      
          if (!decimalPart || decimalPart === '000') {
            return integerPart;
          }
      
          return `${integerPart},${decimalPart}`;
        }
      
        function removeDotsAndLetters(input) {
          return input.replace(/[^0-9]/g, '');
        }
      
        function totalPrice(quantity, price) {
          return parseFloat(quantity) * parseFloat(price);
        }  
      
        let cartItems = document.querySelectorAll(".cart-item__input.quantity");
        const printTotals = document.querySelectorAll('.sumPrice'); // Selector cho tổng giá giỏ hàng
      
        cartItems.forEach((cartItem) => {
          const minusBtn = cartItem.querySelector(".minus-btn");
          const plusBtn = cartItem.querySelector(".plus-btn");
          const quantitySpan = cartItem.querySelector(".quantity"); 
          const priceP = cartItem.parentElement.parentElement.querySelector(".cart-item__price-wrap");
          let price = removeDotsAndLetters(priceP.textContent);
          const totalP = priceP.parentElement.parentElement.querySelector(".cart-item__total-price");
          let quantity = parseInt(quantitySpan.textContent);
      
          const updateTotalPrice = () => {
            let totalProduct = totalPrice(quantity, price);
            totalP.textContent = formatNumber(totalProduct) + " đ";
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
          cartItems.forEach((cartItem) => {
            const priceP = cartItem.parentElement.parentElement.querySelector(".cart-item__price-wrap");

            let price = removeDotsAndLetters(priceP.textContent);
            const totalP = priceP.parentElement.parentElement.querySelector(".cart-item__total-price");
            let totalProduct = parseFloat(removeDotsAndLetters(totalP.textContent));
      
            if (!isNaN(totalProduct)) {
              total += totalProduct;
            }
          });
          
          printTotals.forEach((printTotal) => {
            printTotal.textContent = formatNumber(total) + " đ"; // Cập nhật tổng giá

          });
        }

     

      </script>
      
<script>
let currentUrl = window.location.href;

// Kiểm tra xem URL có chứa từ "cart" không



    function submitForm(e){
        e.preventDefault();
        let btnSubmit = document.querySelector("a.submit");
        let form = btnSubmit.closest("form"); // Lấy thẻ form là cha của button
        console.log(form);
        
        form.submit(); // Gọi phương thức submit của form
    }
    let btnSubmit = document.querySelector("a.submit");
    btnSubmit.addEventListener('click', submitForm);
    let form = btnSubmit.closest("form"); // Lấy thẻ form là cha của button
   
</script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
     function alertAppted(e) {
    e.preventDefault();   // Ngăn chặn hành động mặc định

    let action = document.querySelector("button.is-delete");
    let form = action.closest("form"); // Tìm form gần nhất chứa nút

    swal({
        title: "Bạn có chắc muốn xoá?",
        text: "Dữ liệu sẽ bị xoá vĩnh viễn",
        icon: "warning",  // Sử dụng "icon" thay vì "type"
        buttons: {
            cancel: {
                text: "Huỷ bỏ",      // Tùy chỉnh nút "Huỷ bỏ"
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
         form.submit();
        } else {
            // Người dùng nhấn cancel
          
        }
    });
}

// Chọn tất cả các phần tử có class is-delete
let isAlertElements = document.querySelectorAll(".is-delete");

// Lặp qua các phần tử và gắn sự kiện click cho từng phần tử
isAlertElements.forEach(function (element) {
    element.addEventListener('click', alertAppted);
});   

<c:if test="${not empty success}">

swal( "Thành công" ,  "${success}" ,  "success" )

    
</c:if>
</script>

</html>