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
                    <a href="#!" class="breadcrumbs__link breadcrumbs__link--current">Lịch sử mua hàng</a>
                </li>
            </ul>
        </div>

        <!-- Checkout content -->
        <div class="checkout-container">
            <div class="row gy-xl-3">
                <div class="col-8 col-xl-12">
                    <div class="cart-info">
                        <h1 class="cart-info__heading">Lịch sử mua hàng của bạn</h1>
                        <h2 class="cart-info__heading" style="font-size: 1.8rem;">(Mã KH: ${order.customerCode})</h2>
                        <div class="cart-info__separate"></div>

                      
                        <div class="cart-info__list">
                            <!-- Cart item 1 -->
                            <article class="cart-item">
                                <a src="/client/product-detail.html">
                                    <img
                                        src="/client/assets/img/product/item-1.png"
                                        alt=""
                                        class="cart-item__thumb"
                                    />
                                </a>
                                <div class="cart-item__content">
                                    <div class="cart-item__content-left">
                                        <h3 class="cart-item__title">
                                            <a src="/client/product-detail.html">
                                               ${order.orderDetail[0].product.name}
                                            </a>
                                        </h3>
                                        <p class="cart-item__price-wrap">
                                           <span class="format-price"> ${order.orderDetail[0].product.price}</span>
                                            | <span class="cart-item__status"> ${order.status.displayName}</span>
                                        </p>

                                        <p class="cart-item__price-wrap">
                                            ${order.receiverName} (${order.receiverPhone}),
                                            ${order.receiverAddress} 
                                          </p>
                                        <div class="cart-item__ctrl cart-item__ctrl--md-block">
                                            <div class="cart-item__input">
                                                ${order.orderDetail[0].product.category.name}

                                               
                                            </div>
                                            <div class="cart-item__input">
                                               
                                                <span>Số lượng: ${order.orderDetail[0].quantity}</span>
                                               
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cart-item__content-right">
                                        <p class="cart-item__total-price format-price">${order.orderDetail[0].product.price * order.orderDetail[0].quantity }</p>
                                        <div class="cart-item__ctrl">
                                            <c:if test="${order.status eq 'PENDING'}">
                                                <form action="/cancel-oder" method="post">
                                                  <input
                                                    type="hidden"
                                                    name="${_csrf.parameterName}"
                                                    value="${_csrf.token}"
                                                  />
                                                  <input
                                                    type="hidden"
                                                    value="${order.id}"
                                                    name="orderId"
                                                  />
                                                  <button
                                                    style="margin-left: auto"
                                                    class="cart-item__checkout-btn btn btn--primary btn--rounded is-cancel"
                                                  >
                                                    Huỷ
                                                  </button>
                                                </form>
                                              </c:if>
                                        </div>
                                    </div>
                                </div>
                            </article>

                           
                        </div>
                        <div class="cart-info__bottom d-md-none">
                            <div class="row">
                                <div class="col-8 col-xxl-7">
                                    <div class="cart-info__continue">
                                        <a href="/" class="cart-info__continue-link">
                                            <img
                                                class="cart-info__continue-icon icon"
                                                src="/client/assets/icons/arrow-down-2.svg"
                                                alt=""
                                            />
                                            Quay lại mua sắm
                                        </a>
                                    </div>
                                </div>
                                <div class="col-4 col-xxl-5">
                                    <div class="cart-info__row">
                                        <span>Tạm tính <span class="cart-info__sub-label">(sản phẩm)</span></span>
                                        <span class="format-price">${order.orderDetail[0].product.price * order.orderDetail[0].quantity }</span>
                                    </div>
                                    <div class="cart-info__row">
                                        <span>Phí vận chuyển</span>
                                        <span class="format-price"> ${order.totalPrice - order.orderDetail[0].product.price * order.orderDetail[0].quantity }</span>
                                    </div>
                                    <div class="cart-info__separate"></div>
                                    <div class="cart-info__row cart-info__row--bold">
                                        <span>Tổng :</span>
                                        <span class="format-price">${order.totalPrice}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4 col-xl-12">
                    <div class="cart-info">
                        <div class="cart-info__row">
                            <span>Ngày đặt:</span>
                            <span class="format-date">${order.orderDate}</span>
                            </div>
                        <div class="cart-info__row">
                            <span>Tổng <span class="cart-info__sub-label">(Số lượng):</span></span>
                            <span>3</span>
                        </div>
                        <div class="cart-info__row">
                            <span>Tạm tính <span class="cart-info__sub-label">(sản phẩm):</span></span>
                            <span class="format-price">${order.orderDetail[0].product.price * order.orderDetail[0].quantity }</span>
                        </div>
                        <div class="cart-info__row">
                            <span>Phí vận chuyển:</span>
                            <span class="format-price"> ${order.totalPrice - order.orderDetail[0].product.price * order.orderDetail[0].quantity }</span>
                        </div>
                        <div class="cart-info__separate"></div>
                        <div class="cart-info__row">
                            <span class="cart-item__total-price">Tổng:</span>
                          <span class=" cart-item__total-price format-price sum-total">${order.totalPrice}</span>
                        </div>
                        
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</main>


<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->

