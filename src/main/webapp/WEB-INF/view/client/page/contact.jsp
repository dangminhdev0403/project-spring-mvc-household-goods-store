<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="checkout-page">
    <div class="container">
        <!-- Search bar -->
        <div class="checkout-container">
            <div class="search-bar d-none d-md-flex">
                <input type="text" name="" id="" placeholder="Search for item" class="search-bar__input" />
                <button class="search-bar__submit">
                    <img src="/client/assets/icons/search.svg" alt="" class="search-bar__icon icon" />
                </button>
            </div>
        </div>

        <!-- Breadcrumbs -->
        <div class="checkout-container">
            <ul class="breadcrumbs checkout-page__breadcrumbs">
                <li>
                    <a href="/" class="breadcrumbs__link">
                        Trang chủ 
                        <img src="/client/assets/icons/arrow-right.svg" alt="" />
                    </a>
                </li>
                <li>
                    <a href="/contact" class="breadcrumbs__link">
                     Liên hệ
                        <img src="/client/assets/icons/arrow-right.svg" alt="" />
                    </a>
                </li>
              
            </ul>
        </div>

        <!-- Checkout content -->
        <div class="checkout-container">
            <div class="row gy-xl-3">
                <div class="col-12 col-xl-12">
                    <div class="cart-info">
                        <h1 class="cart-info__heading">Thông tin liên hệ</h1>
                        <div class="cart-info__separate"></div>

                        <article class="cart-item" style="display: block; padding: 0;">
                            <p style="padding: 2rem;"><strong>Địa chỉ:</strong> 123 Đường ABC, Quận XYZ, TP. HCM</p>
                            <p style="padding: 2rem;"><strong>Điện thoại:</strong> 0343921331</p>
                            <p style="padding: 2rem;"><strong>Email:</strong> support@tenwebsite.com</p>
                            <p style="padding: 2rem;"><strong>Giờ làm việc:</strong> Thứ 2 - Thứ 6, 8:00 - 17:00</p>
        
                                            </article>

                    </div>
                </div>
               
            </div>
        </div>
    </div>
</main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->

