<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<footer id="footer" class="footer">
    <div class="container">
        <div class="footer__row">
            <!-- Cột 1 -->
            <div class="footer__col">
                <!-- Logo -->
                <a href="/" class="logo footer__logo">
                    <img src="/client/assets/icons/logo.svg" alt="Thế Giới Gia Dụng" class="logo__img" />
                    <h1 class="logo__title">Thế Giới Gia Dụng</h1>
                </a>
                <p class="footer__desc">
                    Thế Giới Gia Dụng - nơi bạn tìm thấy những sản phẩm tốt nhất cho nhu cầu hàng ngày của bạn.
                </p>

                
            </div>

            <!-- Cột 2 -->
            <div class="footer__col">
                <h3 class="footer__heading">Mua sắm</h3>
                <ul class="footer__list">
                    <li><a href="#!" class="footer__link">Tất cả các ngành hàng</a></li>
                    <li><a href="#!" class="footer__link">Khuyến mãi Thời trang</a></li>
                    <li><a href="#!" class="footer__link">Giảm giá Điện tử</a></li>
                    <li><a href="#!" class="footer__link">Ưu đãi Nội thất & Gia đình</a></li>
                    <li><a href="#!" class="footer__link">Ưu đãi Sắc đẹp</a></li>
                </ul>
            </div>

            <!-- Cột 3 -->
            <div class="footer__col">
                <h3 class="footer__heading">Hỗ trợ</h3>
                <ul class="footer__list">
                    <li><a href="#!" class="footer__link">Tìm cửa hàng</a></li>
                    <li><a href="#!" class="footer__link">Trạng thái đơn hàng</a></li>
                </ul>
            </div>

            <!-- Cột 4 -->
            <div class="footer__col">
                <h3 class="footer__heading">Công ty</h3>
                <ul class="footer__list">
                    <li><a href="#!" class="footer__link">Dịch vụ khách hàng</a></li>
                    <li><a href="#!" class="footer__link">Điều khoản sử dụng</a></li>
                    <li><a href="#!" class="footer__link">Chính sách bảo mật</a></li>
                    <li><a href="#!" class="footer__link">Tuyển dụng</a></li>
                    <li><a href="#!" class="footer__link">Giới thiệu</a></li>
                    <li><a href="#!" class="footer__link">Liên kết</a></li>
                </ul>
            </div>

            <!-- Cột 5 -->
            <div class="footer__col">
                <h3 class="footer__heading">Liên hệ</h3>
                <ul class="footer__list">
                    <li><p class="footer__label">Email</p><a href="mailto:contact@Thế Giới Gia Dụng.com" class="footer__link">contact@Thế Giới Gia Dụng.com</a></li>
                    <li><p class="footer__label">Hotline</p><a href="tel:18008888" class="footer__link">18008888</a></li>
                    <li><p class="footer__label">Địa chỉ</p><p class="footer__text">Số 11D, Lô A10, Khu đô thị Nam Trung Yên, Phường Yên Hòa, Quận Cầu Giấy, TP. Hà Nội</p></li>
                    <li><p class="footer__label">Giờ làm việc</p><p class="footer__text">Thứ 2 - Thứ 6 08:00 sáng - 06:00 chiều</p></li>
                </ul>
            </div>
        </div>

        <div class="footer__bottom">
            <p class="footer__copyright">© 2010 - 2025 Thế Giới Gia Dụng. Bản quyền thuộc về Thế Giới Gia Dụng.</p>
    
            <div class="footer__socials">
                <a href="#!" class="footer__social-link footer__social-link--facebook"><img src="/client/assets/icons/facebook.svg" alt="" class="footer__social-icon" /></a>
                <a href="#!" class="footer__social-link footer__social-link--youtube"><img src="/client/assets/icons/youtube.svg" alt="" class="footer__social-icon" /></a>
                <a href="#!" class="footer__social-link footer__social-link--tiktok"><img src="/client/assets/icons/tiktok.svg" alt="" class="footer__social-icon" /></a>
                <a href="#!" class="footer__social-link footer__social-link--twitter"><img src="/client/assets/icons/twitter.svg" alt="" class="footer__social-icon" /></a>
                <a href="#!" class="footer__social-link footer__social-link--linkedin"><img src="/client/assets/icons/linkedin.svg" alt="" class="footer__social-icon" /></a>
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
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/validate.js/0.13.1/validate.min.js"></script>





<script src="/client/assets/js/validate.js"></script>
<script src="/client/assets/js/axios.js"></script>
<script src="/client/assets/js/myscripts.js"></script>

<!-- Thêm thẻ <p> để hiển thị thông điệp -->
    
      
<script>




function submitForm(e) {
    e.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>
    let btnSubmit = e.currentTarget; // Lấy nút đã được nhấn
    let form = btnSubmit.closest("form"); // Lấy thẻ form là cha của button
    
    if (form) {
        form.submit(); // Gọi phương thức submit của form
    }
}

let btnSubmit = document.querySelectorAll("a.submit");

if (btnSubmit) {
    btnSubmit.forEach(btn => {
        btn.addEventListener('click', submitForm); // Gọi hàm submitForm khi nhấn nút
    });
}
   
</script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>


<script>
    // const v0Loader = createV0Loader();
    // v0Loader.show()


     function alertAppted(e , element , notice ,message ) {
      
    e.preventDefault();   // Ngăn chặn hành động mặc định

    let form = element.closest("form"); // Tìm form gần nhất chứa nút

    swal({
        title: notice ,
        text: message,
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
let isCancels = document.querySelectorAll(".is-cancel");
let isAccept= document.querySelectorAll(".is-accept");

// Lặp qua các phần tử và gắn sự kiện click cho từng phần tử
isAlertElements.forEach(function (element) {
    element.addEventListener('click', function (e) {
        alertAppted(e,element, "Xác nhận", "Bạn có chắc chắn muốn xóa không?");
    });
}); 

isCancels.forEach(function (element) {
    element.addEventListener('click', function (e) {
        alertAppted(e,element, "Xác nhận", "Bạn có chắc chắn muốn huỷ đơn hàng?");
    });
}); 

isAccept.forEach(function (element) {
    element.addEventListener('click', function (e) {
        alertAppted(e,element, "Xác nhận", "Bạn có chắc chắn muốn thay đổi?");
    });
}); 


<c:if test="${not empty error}">

swal( "Lỗi" ,  "${error}" ,  "error" )

    
</c:if>


const notice = "Xác nhận đặt hàng";
const message = "Bạn có chắc chắn muốn đặt hàng không?";

let isCheckOut = document.querySelector('#place-hoder');
if(isCheckOut){
    isCheckOut.addEventListener('click', function (e) {
        alertAppted(e,isCheckOut, notice, message);
    });
}







<c:if test="${not empty success}">

swal( "Thành công" ,  "${success}" ,  "success" )

    
</c:if>



</script>


</html>