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
                <a href="#!" class="breadcrumbs__link breadcrumbs__link--current"
                  >Thông tin thanh toán</a
                >
              </li>
            </ul>
          </div>

        <!-- Checkout content -->
        <div class="checkout-container">
            <div class="row gy-xl-3">
                <div class="col-8 col-xl-8 col-lg-12">
                    <div class="cart-info">
                        <h1 class="cart-info__heading">1.Thông tin đơn hàng</h1>
                        <div class="cart-info__separate"></div>
                        <div class="cart-info__list">
                            <!-- Cart item 1 -->
                            <article class="cart-item">
                                <a href="/product/${product.product_id}">
                                    <img
                                      src="${product.productImages[0].url}"
                                      alt=""
                                      class="cart-item__thumb"
                                    />
                                  </a>
                                <div class="cart-item__content">
                                    <div class="cart-item__content-left">
                                        <h3 class="cart-item__title">
                                            <a href="/product/${product.product_id}">
                                                ${product.name}
                                              </a>
                                        </h3>

                                        <p class="cart-item__price-wrap">
                                           <span class="cart-item__status format-price">${product.price}</span>
                                        </p>
                                        <div class="cart-item__ctrl cart-item__ctrl--md-block">
                                            <div class="cart-item__input">
                                                ${product.category.name}
                                            </div>
                                            <div class="cart-item__input quantity">
                                                <button class="cart-item__input-btn "  id ="prev-btn">
                                                  <img
                                                    class="icon"
                                                    src="/client/assets/icons/minus.svg"
                                                    alt=""
                                                  />
                                                </button>
                                                <span class="quantity" >
                                                  ${qty}</span
                                                >
                                                <button class="cart-item__input-btn " id ="next-btn">
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
                                        <p class="cart-item__total-price format-price">${product.price * qty}</p>
                                      
                                    </div>
                                </div>
                            </article>

                        
                        </div>
                        <div class="cart-info__bottom d-md-none">
                            <div class="row">
                                <div class="col-8 col-xxl-7">
                                    <div class="cart-info__continue">
                                        <a href="/" class="cart-info__continue-link">
                                            <img class="cart-info__continue-icon icon" src="/client/assets/icons/arrow-down-2.svg" alt="">
                                           Quay lại mua sắm
                                        </a>
                                    </div>
                                </div>
                                <div class="col-4 col-xxl-5">
                                    <div class="cart-info__row">
                                        <span>Tạm tính: </span>
                                        <span class="format-price sumPrice" id="sub-total">${product.price * qty}</span>
                                    </div>
                                    <div class="cart-info__row">
                                        <span>Phí vận chuyển:</span>
                                        <span class="format-price shipping-price">100000</span>
                                    </div>
                                    <div class="cart-info__separate"></div>
                                    <div class="cart-info__row cart-info__row--bold">
                                        <span>Tổng:</span>
                                        <span class="cart-item__total-price format-price sum-total" 
                >2000000</span>                                 </div>





                                </div>
                            </div>
                        </div>
                    </div>
                        

                    <div class="cart-info">
                        <h2 class="cart-info__heading">2.Phương thức thanh toán</h2>
                        <div class="cart-info__separate"></div>
                        <h3 class="cart-info__sub-heading">Chọn hình thức thanh toán</h3>
            
                        <c:forEach var="pay" items="${listPay}" varStatus="sAd">
            
                        <label>
                          <article class="payment-item payment-item--pointer">
                            <img
                              src="${pay.urlIcon}"
                              alt=""
                              class="payment-item__thumb"
                            />
                            <div class="payment-item__content">
                              <div class="payment-item__info">
                                <h3 class="payment-item__title">
                                  ${pay.name}
                                </h3>
                              </div>
            
                              <span class="cart-info__checkbox payment-item__checkbox">
                                <input
                                  type="radio"
                                  name="delivery-method"
                                 
                                  class="cart-info__checkbox-input payment-item__checkbox-input"
                                />
                                <span class="payment-item__cost format-price sumPrice"
                                  >${pay.price}
                                </span>
                              </span>
                            </div>
                          </article>
                        </label>
            
                        </c:forEach>
                 
            
                    
                      </div>
                </div>
                <div class="col-4 col-xl-4 col-lg-12">
                    <div class="cart-info">
                        <h2 class="cart-info__heading cart-info__heading--lv2">Thông tin thanh toán</h2>
                        <p class="cart-info__desc">
                            Hoàn tất đơn hàng của bạn bằng cách cung cấp thông tin chi tiết thanh toán.
                        </p>
                        <form action="/place-horder-now" class="form cart-info__form" method="post">
                            <div class="form__group">
                                <label for="email" class="form__label form__label--medium">Địa chỉ email</label>
                                <p  style="display: block; font-size: 1.7rem; color: rgb(27, 212, 85);">Bạn có thể xem lịch sử đơn hàng tại email</p>

                                <div class="form__text-input">
                                    <input
                                        type="email"
                                        name="email"
                                        id="email"
                                        placeholder="Email"
                                        class="form__input"
                                        required
                                    />
                                    <img
                                        src="/client/assets/icons/form-error.svg"
                                        alt=""
                                        class="form__input-icon-error"
                                    />
                                </div>
                                <p class="form__error">Email không đúng định dạng</p>
                            </div>
                            <div class="form__group">
                                <label for="card-holder" class="form__label form__label--medium">
                                   Tên người nhận
                                </label>
                                <div class="form__text-input">
                                    <input
                                        type="text"
                                        name="card-holder"
                                        id="card-holder"
                                        placeholder="Tên người nhận"
                                        class="form__input"
                                        required
                                    />
                                    <img
                                        src="/client/assets/icons/form-error.svg"
                                        alt=""
                                        class="form__input-icon-error"
                                    />
                                </div>
                                <p class="form__error">Chưa nhập tên</p>
                            </div>


                            <div class="form__group">
                                <label for="card-details" class="form__label form__label--medium">
                                   Địa chỉ 
                                </label>
                                <div class="form__text-input">
                                    <input
                                        type="text"
                                        name="card-details"
                                        id="card-details"
                                        placeholder="Địa chỉ nhận hàng"
                                        class="form__input"
                                        required
                                    />
                                    <img
                                        src="/client/assets/icons/form-error.svg"
                                        alt=""
                                        class="form__input-icon-error"
                                    />
                                </div>
                            </div>
                            <input type="text" id ="total-place" name="total-place" style="display: block;">

                        </form>
                        <div class="cart-info__row">
                            <span
                              >Tổng <span class="cart-info__sub-label">(sản phẩm)</span></span
                            >
                            <span class="stock quantity">${qty}</span>
                          </div>
                          <div class="cart-info__row">
                            <span>Tổng <span class="cart-info__sub-label">(giá)</span></span>
                            <span class="format-price sumPrice">${product.price * qty}</span>
                        </div>
                          <div class="cart-info__row">
                            <span>Phí vận chuyển</span>
                            <span class="format-price shipping-price">100000</span>
                          </div>
                          <div class="cart-info__separate"></div>
                          <div class="cart-info__row">
                            <span class="cart-item__total-price">Tổng:</span>
                            <span class="cart-item__total-price format-price sum-total"
                              >2000000</span
                            >
                          </div>
                        <a href="#!" class="cart-info__next-btn btn btn--primary btn--rounded " >Đặt hàng</a>
                    </div>
                    <div class="cart-info">
                        <a href="#!">
                          <article class="gift-item">
                            <div class="gift-item__icon-wrap">
                              <img src="/client/assets/icons/gift.svg" alt="" class="gift-item__icon">
                            </div>
                            <div class="gift-item__content">
                              <h3>Gửi món quà này cho người bạn yêu thương.</h3>
                              <p>
                                  Các mặt hàng có sẵn sẽ được vận chuyển đến người nhận  của bạn.
                              </p>
                            </div>
                          </article>
                        </a>
                      </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Footer -->

<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
