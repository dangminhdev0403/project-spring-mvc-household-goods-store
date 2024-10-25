<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<!-- Header -->
<jsp:include page="../layout/header.jsp" />

<!-- MAIN -->
<main class="checkout-page">
    <div class="container">
        <!-- Search bar -->
        <div class="checkout-container">
            <div class="search-bar d-none d-md-flex">
                <input type="text" name="" id="" placeholder="Search for item" class="search-bar__input" />
                <button class="search-bar__submit">
                    <img  src="/client/assets/icons/search.svg" alt="" class="search-bar__icon icon" />
                </button>
            </div>
        </div>

        <!-- Breadcrumbs -->
        <div class="checkout-container">
            <ul class="breadcrumbs checkout-page__breadcrumbs">
                <li>
                    <a href="/" class="breadcrumbs__link">
                        Trang chủ
                        <img  src="/client/assets/icons/arrow-right.svg" alt="" />
                    </a>
                </li>
                <li>
                    <a href="/cart" class="breadcrumbs__link">
                        Giỏ hàng
                        <img  src="/client/assets/icons/arrow-right.svg" alt="" />
                    </a>
                </li>
                <li>
                    <a href="#!" class="breadcrumbs__link breadcrumbs__link--current">Vận chuyển</a>
                </li>
            </ul>
        </div>

        <!-- Checkout content -->
        <div class="checkout-container">
            <div class="row gy-xl-3">
                <div class="col-8 col-xl-12">
                    <div class="cart-info">
                        <h1 class="cart-info__heading">1. Shipping, arrives between Mon, May 16—Tue, May 24</h1>
                        <div class="cart-info__separate"></div>

                        <!-- Checkout address -->
                        <div class="user-address">
                            <div class="user-address__top">
                                <div>
                                    <h2 class="user-address__title">Shipping address</h2>
                                    <p class="user-address__desc">Where should we deliver your order?</p>
                                </div>
                                <button
                                    class="user-address__btn btn btn--primary btn--rounded btn--small js-toggle"
                                    toggle-target="#add-new-address"
                                >
                                    <img  src="/client/assets/icons/plus.svg" alt="" />
                                    Add a new address
                                </button>
                            </div>
                            <div class="user-address__list">
                                <!-- Empty message -->
                                <!-- <p class="user-address__message">
                                    Not address yet.
                                    <a class="user-address__link js-toggle" href="#!" toggle-target="#add-new-address">Add a new address</a>
                                </p> -->

                                <!-- Address card 1 -->
                                <article class="address-card">
                                    <div class="address-card__left">
                                        <div class="address-card__choose">
                                            <label class="cart-info__checkbox">
                                                <input
                                                    type="radio"
                                                    name="shipping-adress"
                                                    checked
                                                    class="cart-info__checkbox-input"
                                                />
                                            </label>
                                        </div>
                                        <div class="address-card__info">
                                            <h3 class="address-card__title">Imran Khan</h3>
                                            <p class="address-card__desc">
                                                Museum of Rajas, Sylhet Sadar, Sylhet 3100.
                                            </p>
                                            <ul class="address-card__list">
                                                <li class="address-card__list-item">Shipping</li>
                                                <li class="address-card__list-item">Delivery from store</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="address-card__right">
                                        <div class="address-card__ctrl">
                                            <button
                                                class="cart-info__edit-btn js-toggle"
                                                toggle-target="#add-new-address"
                                            >
                                                <img class="icon"  src="/client/assets/icons/edit.svg" alt="" />
                                                Edit
                                            </button>
                                        </div>
                                    </div>
                                </article>

                                <!-- Address card 2 -->
                                <article class="address-card">
                                    <div class="address-card__left">
                                        <div class="address-card__choose">
                                            <label class="cart-info__checkbox">
                                                <input
                                                    type="radio"
                                                    name="shipping-adress"
                                                    class="cart-info__checkbox-input"
                                                />
                                            </label>
                                        </div>
                                        <div class="address-card__info">
                                            <h3 class="address-card__title">Imran Khan</h3>
                                            <p class="address-card__desc">
                                                Al Hamra City (10th Floor), Hazrat Shahjalal Road, Sylhet,
                                                Sylhet, Bangladesh
                                            </p>
                                            <ul class="address-card__list">
                                                <li class="address-card__list-item">Shipping</li>
                                                <li class="address-card__list-item">Delivery from store</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="address-card__right">
                                        <div class="address-card__ctrl">
                                            <button
                                                class="cart-info__edit-btn js-toggle"
                                                toggle-target="#add-new-address"
                                            >
                                                <img class="icon"  src="/client/assets/icons/edit.svg" alt="" />
                                                Edit
                                            </button>
                                        </div>
                                    </div>
                                </article>
                            </div>
                        </div>

                        <div class="cart-info__separate"></div>

                        <h2 class="cart-info__sub-heading">Items details</h2>
                        <div class="cart-info__list">
                            <!-- Cart item 1 -->
                            <article class="cart-item">
                                <a href="/client/product-detail.html">
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
                                                Coffee Beans - Espresso Arabica and Robusta Beans
                                            </a>
                                        </h3>
                                        <p class="cart-item__price-wrap">
                                            $47.00 | <span class="cart-item__status">In Stock</span>
                                        </p>
                                        <div class="cart-item__ctrl cart-item__ctrl--md-block">
                                            <div class="cart-item__input">
                                                LavAzza
                                                <img
                                                    class="icon"
                                                     src="/client/assets/icons/arrow-down-2.svg"
                                                    alt=""
                                                />
                                            </div>
                                            <div class="cart-item__input">
                                                <button class="cart-item__input-btn">
                                                    <img class="icon"  src="/client/assets/icons/minus.svg" alt="" />
                                                </button>
                                                <span>1</span>
                                                <button class="cart-item__input-btn">
                                                    <img class="icon"  src="/client/assets/icons/plus.svg" alt="" />
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cart-item__content-right">
                                        <p class="cart-item__total-price">$47.00</p>
                                        <div class="cart-item__ctrl">
                                            <button class="cart-item__ctrl-btn">
                                                <img  src="/client/assets/icons/heart-2.svg" alt="" />
                                                Save
                                            </button>
                                            <button
                                                class="cart-item__ctrl-btn js-toggle"
                                                toggle-target="#delete-confirm"
                                            >
                                                <img  src="/client/assets/icons/trash.svg" alt="" />
                                                Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </article>

                            <!-- Cart item 2 -->
                            <article class="cart-item">
                                <a href="/client/product-detail.html">
                                    <img
                                         src="/client/assets/img/product/item-2.png"
                                        alt=""
                                        class="cart-item__thumb"
                                    />
                                </a>
                                <div class="cart-item__content">
                                    <div class="cart-item__content-left">
                                        <h3 class="cart-item__title">
                                            <a href="/client/product-detail.html">
                                                Lavazza Coffee Blends - Try the Italian Espresso
                                            </a>
                                        </h3>
                                        <p class="cart-item__price-wrap">
                                            $53.00 | <span class="cart-item__status">In Stock</span>
                                        </p>
                                        <div class="cart-item__ctrl cart-item__ctrl--md-block">
                                            <div class="cart-item__input">
                                                LavAzza
                                                <img
                                                    class="icon"
                                                     src="/client/assets/icons/arrow-down-2.svg"
                                                    alt=""
                                                />
                                            </div>
                                            <div class="cart-item__input">
                                                <button class="cart-item__input-btn">
                                                    <img class="icon"  src="/client/assets/icons/minus.svg" alt="" />
                                                </button>
                                                <span>1</span>
                                                <button class="cart-item__input-btn">
                                                    <img class="icon"  src="/client/assets/icons/plus.svg" alt="" />
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cart-item__content-right">
                                        <p class="cart-item__total-price">$106.00</p>
                                        <div class="cart-item__ctrl">
                                            <button class="cart-item__ctrl-btn">
                                                <img  src="/client/assets/icons/heart-2.svg" alt="" />
                                                Save
                                            </button>
                                            <button
                                                class="cart-item__ctrl-btn js-toggle"
                                                toggle-target="#delete-confirm"
                                            >
                                                <img  src="/client/assets/icons/trash.svg" alt="" />
                                                Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </article>

                            <!-- Cart item 3 -->
                            <article class="cart-item">
                                <a href="/client/product-detail.html">
                                    <img
                                         src="/client/assets/img/product/item-3.png"
                                        alt=""
                                        class="cart-item__thumb"
                                    />
                                </a>
                                <div class="cart-item__content">
                                    <div class="cart-item__content-left">
                                        <h3 class="cart-item__title">
                                            <a href="/client/product-detail.html">
                                                Qualità Oro Mountain Grown - Espresso Coffee Beans
                                            </a>
                                        </h3>
                                        <p class="cart-item__price-wrap">
                                            $38.65 | <span class="cart-item__status">In Stock</span>
                                        </p>
                                        <div class="cart-item__ctrl cart-item__ctrl--md-block">
                                            <div class="cart-item__input">
                                                LavAzza
                                                <img
                                                    class="icon"
                                                     src="/client/assets/icons/arrow-down-2.svg"
                                                    alt=""
                                                />
                                            </div>
                                            <div class="cart-item__input">
                                                <button class="cart-item__input-btn">
                                                    <img class="icon"  src="/client/assets/icons/minus.svg" alt="" />
                                                </button>
                                                <span>1</span>
                                                <button class="cart-item__input-btn">
                                                    <img class="icon"  src="/client/assets/icons/plus.svg" alt="" />
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cart-item__content-right">
                                        <p class="cart-item__total-price">$38.65</p>
                                        <div class="cart-item__ctrl">
                                            <button class="cart-item__ctrl-btn">
                                                <img  src="/client/assets/icons/heart-2.svg" alt="" />
                                                Save
                                            </button>
                                            <button
                                                class="cart-item__ctrl-btn js-toggle"
                                                toggle-target="#delete-confirm"
                                            >
                                                <img  src="/client/assets/icons/trash.svg" alt="" />
                                                Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </article>
                        </div>
                        <div class="cart-info__bottom d-md-none">
                            <div class="row">
                                <div class="col-8 col-xxl-7">
                                    <div class="cart-info__continue">
                                        <a href="/client/" class="cart-info__continue-link">
                                            <img
                                                class="cart-info__continue-icon icon"
                                                 src="/client/assets/icons/arrow-down-2.svg"
                                                alt=""
                                            />
                                            Continue Shopping
                                        </a>
                                    </div>
                                </div>
                                <div class="col-4 col-xxl-5">
                                    <div class="cart-info__row">
                                        <span>Subtotal:</span>
                                        <span>$191.65</span>
                                    </div>
                                    <div class="cart-info__row">
                                        <span>Shipping:</span>
                                        <span>$10.00</span>
                                    </div>
                                    <div class="cart-info__separate"></div>
                                    <div class="cart-info__row cart-info__row--bold">
                                        <span>Total:</span>
                                        <span>$201.65</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4 col-xl-12">
                    <div class="cart-info">
                        <div class="cart-info__row">
                            <span>Subtotal <span class="cart-info__sub-label">(items)</span></span>
                            <span>3</span>
                        </div>
                        <div class="cart-info__row">
                            <span>Price <span class="cart-info__sub-label">(Total)</span></span>
                            <span>$191.65</span>
                        </div>
                        <div class="cart-info__row">
                            <span>Shipping</span>
                            <span>$10.00</span>
                        </div>
                        <div class="cart-info__separate"></div>
                        <div class="cart-info__row">
                            <span>Estimated Total</span>
                            <span>$201.65</span>
                        </div>
                        <a href="/client/payment.html" class="cart-info__next-btn btn btn--primary btn--rounded">
                            Continue to checkout
                        </a>
                    </div>
                    <div class="cart-info">
                        <a href="#!">
                            <article class="gift-item">
                                <div class="gift-item__icon-wrap">
                                    <img  src="/client/assets/icons/gift.svg" alt="" class="gift-item__icon" />
                                </div>
                                <div class="gift-item__content">
                                    <h3 class="gift-item__title">Send this order as a gift.</h3>
                                    <p class="gift-item__desc">
                                        Available items will be shipped to your gift recipient.
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


<jsp:include page="../layout/footer.jsp" />

<!-- Modal: Xác nhận xoá sản phẩm khỏi giỏ hàng -->
<div id="delete-confirm" class="modal modal--small hide">
    <div class="modal__content">
        <p class="modal__text">Bạn có muốn xoá sản phẩm này khỏi giỏ hàng không?</p>
        <div class="modal__bottom">
            <button class="btn btn--small btn--outline modal__btn js-toggle" toggle-target="#delete-confirm">
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
                        <label for="name" class="form__label form__label--small">Họ và tên</label>
                        <div class="form__text-input form__text-input--small">
                            <input
                                type="text"
                                name="name"
                                id="name"
                                placeholder="Họ và tên"
                                class="form__input"
                                 
                                minlength="2"
                            />
                            <img src="./assets/icons/form-error.svg" alt="" class="form__input-icon-error" />
                        </div>
                        <p class="form__error">Tên phải có ít nhất 2 ký tự</p>
                    </div>
                    <div class="form__group">
                        <label for="phone" class="form__label form__label--small">Số điện thoại</label>
                        <div class="form__text-input form__text-input--small">
                            <input
                                type="tel"
                                name="phone"
                                id="phone"
                                placeholder="Số điện thoại"
                                class="form__input"
                                 
                                minlength="10"
                            />
                            <img src="./assets/icons/form-error.svg" alt="" class="form__input-icon-error" />
                        </div>
                        <p class="form__error">Số điện thoại phải có ít nhất 10 ký tự</p>
                    </div>
                </div>
                <div class="form__group">
                    <label for="address" class="form__label form__label--small">Địa chỉ</label>
                    <div class="form__text-area">
                        <textarea
                            name="address"
                            id="address"
                            placeholder="Địa chỉ (Khu vực và đường)"
                            class="form__text-area-input"
                             
                        ></textarea>
                        <img src="./assets/icons/form-error.svg" alt="" class="form__input-icon-error" />
                    </div>
                    <p class="form__error">Địa chỉ không được để trống</p>
                </div>
                <div class="form__group">
                    <label for="city" class="form__label form__label--small">Thành phố/Quận/Huyện</label>
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
                        <img src="./assets/icons/form-error.svg" alt="" class="form__input-icon-error" />

                        <!-- Hộp thoại chọn -->
                        <div id="city-dialog" class="form__select-dialog hide">
                            <h2 class="form__dialog-heading d-none d-sm-block">Thành phố/Quận/Huyện</h2>
                            <button
                                class="form__close-dialog d-none d-sm-block js-toggle"
                                toggle-target="#city-dialog"
                            >
                                &times
                            </button>
                            <div class="form__search">
                                <input type="text" placeholder="Tìm kiếm" class="form__search-input" />
                                <img src="./assets/icons/search.svg" alt="" class="form__search-icon icon" />
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
                        <input type="checkbox" name="" id="" class="form__checkbox-input d-none" />
                        <span class="form__checkbox-label">Đặt làm địa chỉ mặc định</span>
                    </label>
                </div>
            </div>
            <div class="modal__bottom">
                <button class="btn btn--small btn--text modal__btn js-toggle" toggle-target="#add-new-address">
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
