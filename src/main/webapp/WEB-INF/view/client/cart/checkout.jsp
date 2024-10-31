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
          <a href="/cart" class="breadcrumbs__link">
            Giỏ hàng
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
      <c:if test="${empty cartDetails}">
        <h1
          class="display-2 alert alert-danger text-center"
          style="display: block; font-size: 2.8rem"
        >
          Chưa có sản phẩm để thanh toán
        </h1>
        </c:if>
       

        <c:if test="${ not empty cartDetails}">
      <div class="row gy-xl-3">
        <div class="col-8 col-xl-12">
          <div class="cart-info">
            <h1 class="cart-info__heading">Chọn dịa điểm nhận hàng</h1>
            <div class="cart-info__separate"></div>

            <!-- Checkout address -->
            <div class="user-address">
              <div class="user-address__top">
                <div>
                  <h2 class="user-address__title">Nơi nhận hàng</h2>
                  <p class="user-address__desc">
                    Bạn muốn nhận đơn hàng ở đâu?
                  </p>
                </div>
                <button
                  class="user-address__btn btn btn--primary btn--rounded btn--small js-toggle"
                  toggle-target="#add-new-address"
                >
                  <img src="/client/assets/icons/plus.svg" alt="" />
                  Thêm địa chỉ mới
                </button>
              </div>
              <div class="user-address__list">
                <!-- Empty message -->
                <!-- <p class="user-address__message">
                                    Not address yet.
                                    <a class="user-address__link js-toggle" href="#!" toggle-target="#add-new-address">Add a new address</a>
                                </p> -->
                <div class="cart-info__separate"></div>

                <!-- Address card 1 -->
                <c:if test="${empty addresses}">
                  <p>Danh sách địa chỉ đang rỗng.</p>
                </c:if>
                <c:if test="${not empty addresses}">
                  <c:forEach var="adr" items="${addresses}" varStatus="sAd">
                    <article class="address-card">
                      <div class="address-card__left">
                        <div class="address-card__choose">
                          <label class="cart-info__checkbox">
                            <input
                              type="radio"
                              name="shipping-adress"
                                ${sAd.index == 0 ? 'checked': '' }  
                              class="cart-info__checkbox-input"
                              data-address-id = "${adr.id}"
                            />
                          </label>
                        </div>
                        <div class="address-card__info">
                          <h3 class="address-card__title">
                            ${adr.receiverName}
                          </h3>
                          <p class="address-card__desc">${adr.fullAddress}</p>
                          <ul class="address-card__list">
                            <li class="address-card__list-item">
                              SĐT: ${adr.receiverPhone}
                            </li>
                          </ul>
                        </div>
                      </div>
                      <div class="address-card__right">
                        <div class="cart-item__ctrl" style="min-height: 55%">
                          <button
                            class="js-toggle cart-item__ctrl-btn"
                            toggle-target="#add-new-address"
                          >
                            <img
                              class="icon"
                              src="/client/assets/icons/edit.svg"
                              alt=""
                            />
                            Sửa
                          </button>
                          <button
                            type="submit"
                            class="cart-item__ctrl-btn is-delete"
                            style="
                              color: rgba(223, 132, 107, 0.973);
                              justify-content: space-evenly;
                            "
                            toggle-target="#delete-confirm"
                          >
                            <i class="fas fa-trash"></i>
                            <!-- Tăng kích thước gấp đôi -->
                            Xoá
                          </button>
                        </div>
                      </div>
                    </article>
                  </c:forEach>
                </c:if>
              </div>
            </div>
          </div>
          <!-- payment -->
          <div class="cart-info">
            <h2 class="cart-info__heading">Phương thức thanh toán</h2>
            <div class="cart-info__separate"></div>
            <h3 class="cart-info__sub-heading">Chọn hình thức thanh toán</h3>

            <!-- Payment item 3 -->
            <label>
              <article class="payment-item payment-item--pointer">
                <img
                  src="client/assets/img/payment/delivery-1.png"
                  alt=""
                  class="payment-item__thumb"
                />
                <div class="payment-item__content">
                  <div class="payment-item__info">
                    <h3 class="payment-item__title">
                      Thanh toán khi nhận hàng
                    </h3>
                  </div>

                  <span class="cart-info__checkbox payment-item__checkbox">
                    <input
                      type="radio"
                      name="delivery-method"
                      checked=""
                      class="cart-info__checkbox-input payment-item__checkbox-input"
                    />
                    <span class="payment-item__cost format-price"
                      >1000000
                    </span>
                  </span>
                </div>
              </article>
            </label>

            <!-- Payment item 4 -->
            <label>
              <article class="payment-item payment-item--pointer">
                <img
                  src="client/assets/img/payment/delivery-2.png"
                  alt=""
                  class="payment-item__thumb"
                />
                <div class="payment-item__content">
                  <div class="payment-item__info">
                    <h3 class="payment-item__title">Chuyển khoản ngân hàng</h3>
                  </div>

                  <span class="cart-info__checkbox payment-item__checkbox">
                    <input
                      type="radio"
                      name="delivery-method"
                      class="cart-info__checkbox-input payment-item__checkbox-input"
                    />
                    <span class="payment-item__cost format-price"
                      >2000000
                    </span>
                  </span>
                </div>
              </article>
            </label>
          </div>
          <!-- end payment -->

          <div class="cart-info">
            <h2 class="cart-info__heading">Thông tin đơn hàng</h2>
            <div class="cart-info__separate"></div>
            <h2 class="cart-info__sub-heading">Danh sách mặt hàng của bạn</h2>
            <div class="cart-info__list">
              <!-- Cart item 1 -->
              <c:forEach var="detail" items="${cartDetails}" varStatus="s">
                <article class="cart-item">
                  <a href="/product/${detail.product.product_id}">
                    <img
                      src="/client/assets/img/product/item-1.png"
                      alt=""
                      class="cart-item__thumb"
                    />
                  </a>
                  <div class="cart-item__content">
                    <div class="cart-item__content-left">
                      <h3 class="cart-item__title">
                        <a href="/client/product-detail.html">
                          ${detail.product.name}
                        </a>
                      </h3>
                      <p class="cart-item__price-wrap">
                        <span class="cart-item__status format-price"
                          >${detail.product.price}</span
                        >
                      </p>
                      <div class="cart-item__ctrl cart-item__ctrl--md-block">
                        <div class="cart-item__input">
                          ${detail.product.category.name}
                        </div>
                        <div class="cart-item__input">
                          <p
                            class="cart-item__total-price"
                            style="font-size: 1.9rem"
                          >
                            Số lượng:
                          </p>
                          <span>${detail.quantity}</span>
                        </div>
                      </div>
                    </div>
                    <div class="cart-item__content-right">
                      <p class="cart-item__total-price format-price">
                        ${detail.quantity *detail.product.price}
                      </p>
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
                  <div class="cart-info__row">
                    <span>Tạm tính:</span>
                    <span class="format-price">${totalPrice}</span>
                  </div>
                  <div class="cart-info__row">
                    <span>Phí vận chuyểm:</span>
                    <span class="format-price shipping-price">10.0000</span>
                  </div>
                  <div class="cart-info__separate"></div>
                  <div class="cart-info__row cart-info__row--bold">
                    <span>Tổng:</span>
                    <span class="format-price sum-total">201.65</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-4 col-xl-12">
          <div class="cart-info">
            <div class="cart-info__row">
              <span
                >Tổng <span class="cart-info__sub-label">(sản phẩm)</span></span
              >
              <span>${totalProduct}</span>
            </div>
            <div class="cart-info__row">
              <span>Tổng <span class="cart-info__sub-label">(giá)</span></span>
              <span class="format-price" id="sub-total">${totalPrice}</span>
            </div>
            <div class="cart-info__row">
              <span>Phí vận chuyển</span>
              <span class="format-price shipping-price">100000</span>
            </div>
            <div class="cart-info__separate"></div>
            <div class="cart-info__row">
              <span class="cart-item__total-price">Tổng ước tính:</span>
              <span class="cart-item__total-price format-price sum-total"
                >2000000</span
              >
            </div>

           

            <form method="POST" action="/place-oder">
              <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />
            <input type="text" id ="total-place" name="total-place" style="display: none;">
              <c:if test="${not empty addresses}">
                <c:forEach var="ad" items="${addresses}" varStatus="sAd">
                  <input type="radio" name="addressId" value="${ad.id}" id ="address-select-${ad.id}" style="display: none;">
                </c:forEach>

                <a
                style="cursor: pointer;"
                id="place-hoder"
                class="cart-info__next-btn btn btn--primary btn--rounded"
              >
                Đặt hàng
              </a>
              </c:if>
              <c:if test="${empty addresses}">
                <a
            
                class="cart-info__next-btn btn btn--primary btn--rounded"
                style="cursor: not-allowed; pointer-events: none; background-color: #dc3545; color: #fff;"

              >
                <h1>Thêm địa chỉ để tiếp tục</h1>
                </a>
              </c:if>
             

            </form>

            
            
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
      </c:if>
    </div>
  </div>
</main>

<jsp:include page="../layout/footer.jsp" />

<!-- Modal: Xác nhận xoá sản phẩm khỏi giỏ hàng -->
<div id="delete-confirm" class="modal modal--small hide">
  <div class="modal__content">
    <p class="modal__text">Bạn có muốn xoá sản phẩm này khỏi giỏ hàng không?</p>
    <div class="modal__bottom">
      <button
        class="btn btn--small btn--outline modal__btn js-toggle"
        toggle-target="#delete-confirm"
      >
        Hủy
      </button>
      <button
        class="btn btn--small btn--danger btn--primary modal__btn btn--no-margin js-toggle"
        toggle-target="#delete-confirm"
      >
        Xóa
      </button>
    </div>
  </div>
  <div class="modal__overlay js-toggle" toggle-target="#delete-confirm"></div>
</div>

<!-- Modal: Địa chỉ mới cho giao hàng -->
<div id="add-new-address" class="modal hide" style="--content-width: 650px">
  <div class="modal__content">
    <form action="" class="form">
      <h2 class="modal__heading">Thêm địa chỉ giao hàng mới</h2>
      <div class="modal__body">
        <div class="form__row">
          <div class="form__group">
            <label for="name" class="form__label form__label--small"
              >Họ và tên</label
            >
            <div class="form__text-input form__text-input--small">
              <input
                type="text"
                name="name"
                id="name"
                placeholder="Họ và tên"
                class="form__input"
                minlength="2"
              />
              <img
                src="client/assets/icons/form-error.svg"
                alt=""
                class="form__input-icon-error"
              />
            </div>
            <p class="form__error">Tên phải có ít nhất 2 ký tự</p>
          </div>
          <div class="form__group">
            <label for="phone" class="form__label form__label--small"
              >Số điện thoại</label
            >
            <div class="form__text-input form__text-input--small">
              <input
                type="tel"
                name="phone"
                id="phone"
                placeholder="Số điện thoại"
                class="form__input"
                minlength="10"
              />
              <img
                src="client/assets/icons/form-error.svg"
                alt=""
                class="form__input-icon-error"
              />
            </div>
            <p class="form__error">Số điện thoại phải có ít nhất 10 ký tự</p>
          </div>
        </div>
        <div class="form__group">
          <label for="address" class="form__label form__label--small"
            >Địa chỉ</label
          >
          <div class="form__text-area">
            <textarea
              name="address"
              id="address"
              placeholder="Địa chỉ (Khu vực và đường)"
              class="form__text-area-input"
            ></textarea>
            <img
              src="client/assets/icons/form-error.svg"
              alt=""
              class="form__input-icon-error"
            />
          </div>
          <p class="form__error">Địa chỉ không được để trống</p>
        </div>
        <div class="form__group">
          <label for="city" class="form__label form__label--small"
            >Thành phố/Quận/Huyện</label
          >
          <div class="form__text-input form__text-input--small">
            <input
              type="text"
              name=""
              placeholder="Thành phố/Quận/Huyện"
              id="city"
              readonly
              class="form__input js-toggle"
              toggle-target="#city-dialog"
            />
            <img
              src="client/assets/icons/form-error.svg"
              alt=""
              class="form__input-icon-error"
            />

            <!-- Hộp thoại chọn -->
            <div id="city-dialog" class="form__select-dialog hide">
              <h2 class="form__dialog-heading d-none d-sm-block">
                Thành phố/Quận/Huyện
              </h2>
              <button
                class="form__close-dialog d-none d-sm-block js-toggle"
                toggle-target="#city-dialog"
              >
                &times
              </button>
              <div class="form__search">
                <input
                  type="text"
                  placeholder="Tìm kiếm"
                  class="form__search-input"
                />
                <img
                  src="client/assets/icons/search.svg"
                  alt=""
                  class="form__search-icon icon"
                />
              </div>
              <div class="form__options-list">
                <li class="form__option">Hà Nội</li>
                <li class="form__option form__option--current">Hồ Chí Minh</li>
                <li class="form__option">Đà Nẵng</li>
                <!-- Thêm các tùy chọn khác ở đây -->
              </div>
            </div>
          </div>
          <p class="form__error">Số điện thoại phải có ít nhất 11 ký tự</p>
        </div>
        <div class="form__group form__group--inline">
          <label class="form__checkbox">
            <input
              type="checkbox"
              name=""
              id=""
              class="form__checkbox-input d-none"
            />
            <span class="form__checkbox-label">Đặt làm địa chỉ mặc định</span>
          </label>
        </div>
      </div>
      <div class="modal__bottom">
        <button
          class="btn btn--small btn--text modal__btn js-toggle"
          toggle-target="#add-new-address"
        >
          Hủy
        </button>
        <button
          class="btn btn--small btn--primary modal__btn btn--no-margin js-toggle"
          toggle-target="#add-new-address"
        >
          Tạo
        </button>
      </div>
    </form>
  </div>
  <div class="modal__overlay"></div>
</div>
