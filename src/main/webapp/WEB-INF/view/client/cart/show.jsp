<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />

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
          <a href="/cart" class="breadcrumbs__link breadcrumbs__link--current"
            >Giỏ hàng</a
          >
        </li>
      </ul>
    </div>

    <!-- Checkout content -->
    <div class="checkout-container">
      <c:if test="${empty cartDetails}">
        <h1
          class="display-2 alert alert-danger text-center"
          style="display: block; font-size: 2.8rem"
        >
          Giỏ hàng của bạn đang trống.
        </h1>
      </c:if>
      <div class="row gy-xl-3">
        <c:if test="${not empty cartDetails}">
          <div class="col-8 col-xl-12">
            <div class="cart-info">
              <div class="cart-info__list">
                <c:forEach var="detail" items="${cartDetails}" varStatus="s">
                  <article class="cart-item">
                    <a href="/product/${detail.product.product_id}">
                      <img
                        src="/upload/products/${detail.product.productImages[0].name}"
                        alt=""
                        class="cart-item__thumb"
                      />
                    </a>
                    <div class="cart-item__content">
                      <div class="cart-item__content-left">
                        <h3 class="cart-item__title">
                          <a href="/product/{detail.product.product_id}">
                            ${detail.product.name}
                          </a>
                        </h3>

                        <p
                          class="cart-item__price-wrap cart-item__status"
                          contenteditable="true"
                        >
                          <c:choose>
                            <c:when test="${detail.product.price != null}">
                              <c:if test="${detail.product.price % 1 != 0}">
                                <fmt:formatNumber
                                  value="${detail.product.price}"
                                  pattern="#,##0.000"
                                />
                                đ
                              </c:if>
                              <c:if test="${detail.product.price % 1 == 0}">
                                <fmt:formatNumber
                                  value="${detail.product.price}"
                                  pattern="#,##0"
                                />
                                đ
                              </c:if>
                            </c:when>
                          </c:choose>
                        </p>
                        <div class="cart-item__ctrl cart-item__ctrl--md-block">
                          <div class="cart-item__input">
                            ${detail.product.category.name}
                            <!-- <img
                            class="icon"
                            src="/client/assets/icons/arrow-down-2.svg"
                            alt=""
                          /> -->
                          </div>
                          <div class="cart-item__input quantity">
                            <button class="cart-item__input-btn minus-btn">
                              <img
                                class="icon"
                                src="/client/assets/icons/minus.svg"
                                alt=""
                              />
                            </button>
                            <span class="quantity" data-cart-index = "${s.index}">
                              ${detail.quantity}</span
                            >
                            <button class="cart-item__input-btn plus-btn">
                              <img
                                class="icon"
                                src="/client/assets/icons/plus.svg"
                                alt=""
                              />
                            </button>
                          </div>
                        </div>
                      </div>
                      <div class="cart-item__content-right">
                        <p
                          class="cart-item__total-price"
                          contenteditable="true"
                        >
                          <c:choose>
                            <c:when
                              test="${detail.quantity * detail.product.price != null}"
                            >
                              <c:if
                                test="${detail.quantity * detail.product.price % 1 != 0}"
                              >
                                <fmt:formatNumber
                                  value="${detail.quantity * detail.product.price}"
                                  pattern="#,##0.000"
                                />
                                đ
                              </c:if>
                              <c:if
                                test="${detail.quantity * detail.product.price % 1 == 0}"
                              >
                                <fmt:formatNumber
                                  value="${detail.quantity * detail.product.price}"
                                  pattern="#,##0"
                                />
                                đ
                              </c:if>
                            </c:when>
                          </c:choose>
                        </p>
                        <div class="cart-item__ctrl">
                          <button class="cart-item__ctrl-btn">
                            <img
                              src="/client/assets/icons/heart-2.svg"
                              alt=""
                            />
                            Save
                          </button>

                          <form
                            action="/delete-cart/${detail.id}"
                            method="POST"
                          >
                            <input
                              type="hidden"
                              name="${_csrf.parameterName}"
                              value="${_csrf.token}"
                            />
                            <button
                              type="submit"
                              class="cart-item__ctrl-btn is-delete"
                              style="color: rgba(236, 77, 33, 0.973)"
                              toggle-target="#delete-confirm"
                            >
                              <i class="fas fa-trash"></i>
                              <!-- Tăng kích thước gấp đôi -->
                              Xoá
                            </button>
                          </form>
                        </div>
                      </div>
                    </div>
                  </article>
                </c:forEach>
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
                        Tiếp tục mua sắm
                      </a>
                    </div>
                  </div>
                  <div class="col-4 col-xxl-5">
                    <div class="cart-info__row cart-info__row--bold">
                      <span>Tổng:</span>
                      <span class="sumPrice format-price">${totalPrice}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-4 col-xl-12">
            <div class="cart-info">
              <div class="cart-info__row">
                <span> Số lượng </span>
                <span class="stock">${totalProduct}</span>
              </div>
              <div class="cart-info__row">
                <span>Tạm tính</span>
                <span class="sumPrice format-price"> ${totalPrice} </span>
              </div>

              <div class="cart-info__separate"></div>
              <div class="cart-info__row cart-info__row--bold">
                <span>Tổng tiền</span>
                <span class="format-price">${totalPrice}</span>
              </div>
              <form:form method="POST" action="/checkout" modelAttribute="cart">
                <c:forEach
                  var="cartD"
                  items="${cart.cartDetails}"
                  varStatus="status"
                >
                  <div style="display: none;">
                    <form:input
                      path="cartDetails[${status.index}].id"
                      value="${cartD.id}"
                    />
                    <form:input
                      path="cartDetails[${status.index}].quantity"
                      value="${cartD.quantity}"
                      class="updateQuantity"
                    />
                  </div>
                </c:forEach>

                <a
                  class="cart-info__next-btn btn btn--primary btn--rounded submit"
                  style="cursor: pointer"
                >
               Nhập thông tin thanh toán.
                </a>
              </form:form>
            </div>
            <div class="cart-info">
              <a href="#!">
                <article class="gift-item">
                  <div class="gift-item__icon-wrap">
                    <img
                      src="/client/assets/icons/gift.svg"
                      alt=""
                      class="gift-item__icon"
                    />
                  </div>
                  <div class="gift-item__content">
                    <h3 class="gift-item__title">
                      Gửi đơn hàng này như một món quà.
                    </h3>
                    <p class="gift-item__desc">
                      Các sản phẩm có sẵn sẽ được giao đến người nhận quà của
                      bạn.
                    </p>
                  </div>
                </article>
              </a>
            </div>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</main>
<jsp:include page="../layout/footer.jsp" />
