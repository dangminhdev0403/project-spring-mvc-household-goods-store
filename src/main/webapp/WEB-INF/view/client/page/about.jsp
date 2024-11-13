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
                    <a href="/about" class="breadcrumbs__link">
                       Giới thiệu
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
                        <h1 class="cart-info__heading">Về Chúng tôi</h1>
                        <div class="cart-info__separate"></div>

                        <article class="cart-item" style="display: block; padding: 0;">
                        <h2 class="cart-info__heading cart-info__heading--lv2" style="padding-bottom: 1rem;">
                            Chào mừng bạn 

                        </h2>
                        <p style="padding-bottom: 3rem;">Chúng tôi cung cấp các vật dụng chất lượng cao và đa dạng cho gia đình và cuộc sống. Với thiết kế hiện đại và tiện dụng, sản phẩm của chúng tôi sẽ giúp bạn nâng cao chất lượng cuộc sống hàng ngày.</p>

                            </article>
                            <article class="cart-item" style="display: block; padding: 0;">
                                <h2 class="cart-info__heading cart-info__heading--lv2" style="padding-bottom: 1rem; padding-top: 2rem;">
                                    Sứ Mệnh Của Chúng Tôi

                                </h2>
                                <p style="padding-bottom: 3rem;">Sứ mệnh của chúng tôi là cung cấp các sản phẩm không chỉ bền bỉ, an toàn mà còn mang lại giá trị cho cuộc sống của bạn. Chúng tôi luôn cải tiến để đáp ứng mọi nhu cầu của khách hàng.</p>

                                    </article>
                                    <article class="cart-item" style="display: block; padding: 0;">
                                        <h2 class="cart-info__heading cart-info__heading--lv2" style="padding-bottom: 1rem; padding-top: 2rem;">
                                            Tại Sao Chọn Chúng Tôi?
        
                                        </h2>
                                        <ul>
                                            <li style="padding-bottom: 3rem;"><strong class="store-highlight">Chất lượng hàng đầu:</strong> Chúng tôi cam kết cung cấp sản phẩm đạt tiêu chuẩn chất lượng và an toàn.</li>
                                            <li style="padding-bottom: 3rem;"><strong class="store-highlight">Dịch vụ tận tâm:</strong> Đội ngũ chăm sóc khách hàng nhiệt tình, luôn sẵn sàng hỗ trợ bạn.</li>
                                            <li style="padding-bottom: 3rem;"><strong class="store-highlight">Giá cả hợp lý:</strong> Mang đến các sản phẩm với mức giá cạnh tranh nhất trên thị trường.</li>
                                        </ul>
        
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

