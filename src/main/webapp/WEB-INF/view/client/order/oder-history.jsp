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
        <input
          type="text"
          name=""
          id=""
          placeholder="Search for item"
          class="search-bar__input"
        />
        <button class="search-bar__submit">
          <img
            src="/client/assets/icons/search.svg"
            alt=""
            class="search-bar__icon icon"
          />
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
          <a
            href="/order-history"
            class="breadcrumbs__link breadcrumbs__link--current"
            >Lịch sử mua hàng</a
          >
        </li>
      </ul>
    </div>

    <!-- Checkout content -->
    <div class="checkout-container">
      <div class="row gy-xl-3">
        <div class="col-12">
          <div class="cart-info">
            <h1 class="cart-info__heading">Lịch sử mua hàng</h1>
            <c:if test ="${empty listOrders}">
              <h1 class="display-2 alert alert-danger text-center" style="display: block; font-size: 2.8rem">
               Bạn chưa có đơn hàng nào.
              </h1>
            </c:if>
            <c:if test ="${not empty listOrders}">
              <p class="cart-info__desc">3 items</p>

              <div class="cart-info__check-all">
                <div class="cart-info__continue">
                  <label class="cart-info__checkbox">
                    <input
                      type="checkbox"
                      name="shipping-adress"
                      class="cart-info__checkbox-input check-all-box"
                      
                    />
                  </label>
                  <a
                    href="/client/checkout.html"
                    style="margin-left: 7.2rem"
                    class="cart-info__checkout-all btn btn--primary btn--rounded is-cancel"
                  >
                    Huỷ đơn đã chọn
                  </a>
                </div>
              </div>
              <div class="cart-info__list">
                <c:forEach var="order" items="${listOrders}">

                  <c:forEach var="orderDetail" items="${order.orderDetail}">
                  <article class="cart-item">
                    <label class="cart-info__checkbox">
                      <input
                        type="checkbox"
                        name="shipping-adress"
                        class="cart-info__checkbox-input checkbox"
                        
                      />
                    </label>
                    <a href="/product/${orderDetail.product.product_id}">
                      <img
                        src="/upload/products/${orderDetail.product.productImages[0].name}"
                        alt=""
                        class="cart-item__thumb"
                      />
                    </a>
                    <div class="cart-item__content">
                      <div class="cart-item__content-left">
                        <h3 class="cart-item__title">
                          <a href="/product/${orderDetail.product.product_id}">
                            ${orderDetail.product.name}
                          </a>
                        </h3>
                       
                        <p class="cart-item__price-wrap ">
                        <span class="format-price">  ${orderDetail.product.price}</span> |
                          <span class="cart-item__status "
                            >${orderDetail.order.status.displayName}</span
                          >
                        </p>
                         <p class="cart-item__price-wrap ">
                          ${order.receiverName} (${order.receiverPhone}),
                          ${order.receiverAddress}
                        </p>
                        <div class="cart-item__ctrl-wrap">
                          <div class="cart-item__ctrl cart-item__ctrl--md-block">
                            <div class="cart-item__input">
                              ${orderDetail.product.category.name}
                            </div>
                            <div class="cart-item__input">
  
                              <span> Số lượng ${orderDetail.quantity}</span>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="cart-item__content-right">
  
                        <p class="cart-item__total-price format-price">
                          ${orderDetail.price} 
                        </p>
  
                        <form action="/can" method="post" class="cart-item__checkout-btn btn btn--primary btn--rounded">
                          <button
                          class="cart-item__checkout-btn btn btn--primary btn--rounded is-cancel"
                        >
                          Huỷ
                        </button>
                        </form>
                       
                      </div>
                    </div>
                  </article>
                </c:forEach>
                </c:forEach>
              </div>
            </c:if>
           

            <div class="cart-info__bottom">
              <div class="cart-info__row cart-info__row-md--block">
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
