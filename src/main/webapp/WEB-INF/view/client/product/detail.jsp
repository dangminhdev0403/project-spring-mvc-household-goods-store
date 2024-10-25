<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="product-page">
  <div class="container">
    <!-- Search bar -->
    <div class="product-container">
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
            src="client/assets/icons/search.svg"
            alt=""
            class="search-bar__icon icon"
          />
        </button>
      </div>
    </div>

    <!-- Breadcrumbs -->
    <div class="product-container">
      <ul class="breadcrumbs">
        <li>
          <a href="/" class="breadcrumbs__link">
            Trang chủ
            <img src="/client/assets/icons/arrow-right.svg" alt="" />
          </a>
        </li>
        <li>
          <a href="/category" class="breadcrumbs__link">
            ${product.category.name}
            <img src="/client/assets/icons/arrow-right.svg" alt="" />
          </a>
        </li>
        <li>
          <a href="/product/${product.product_id}" class="breadcrumbs__link">
            ${product.name}
          </a>
        </li>
      </ul>
    </div>

    <!-- Product info -->
    <div class="product-container prod-info-content">
      <div class="row">
        <div class="col-5 col-xl-6 col-lg-12">
          <div class="prod-preview">
            <div class="prod-preview__list">
              <c:forEach var="image" items="${product.productImages}">
                <div class="prod-preview__item">
                  <img
                    src="/upload/products/${image.name}"
                    alt=""
                    class="prod-preview__img"
                  />
                </div>
              </c:forEach>

              <!--  -->
              <div class="prod-preview__item">
                <img
                  src="/client/assets/img/product/item-2.png"
                  alt=""
                  class="prod-preview__img"
                />
              </div>
              <div class="prod-preview__item">
                <img
                  src="/client/assets/img/product/item-3.png"
                  alt=""
                  class="prod-preview__img"
                />
              </div>
              <div class="prod-preview__item">
                <img
                  src="/client/assets/img/product/item-4.png"
                  alt=""
                  class="prod-preview__img"
                />
              </div>
            </div>
            <div class="prod-preview__thumbs">
              <c:forEach var="image" items="${product.productImages}">
                <img
                  src="/upload/products/${image.name}"
                  alt="${image.name}"
                  class="prod-preview__thumb-img prod-preview__thumb-img--current"
                />
              </c:forEach>
              <img
                src="/client/assets/img/product/item-1.png"
                alt=""
                class="prod-preview__thumb-img prod-preview__thumb-img--current"
              />
              <img
                src="/client/assets/img/product/item-2.png"
                alt=""
                class="prod-preview__thumb-img"
              />
              <img
                src="/client/assets/img/product/item-3.png"
                alt=""
                class="prod-preview__thumb-img"
              />
              <img
                src="/client/assets/img/product/item-4.png"
                alt=""
                class="prod-preview__thumb-img"
              />
            </div>
          </div>
        </div>
        <div class="col-7 col-xl-6 col-lg-12">
          <section class="prod-info">
            <h1 class="prod-info__heading">${product.name}</h1>
            <div class="row">
              <div class="col-5 col-xxl-6 col-xl-12">
                <!-- review -->
                <!-- <div class="prod-prop">
                                        <img src="/client/assets/icons/star.svg" alt="" class="prod-prop__icon" />
                                        <h4 class="prod-prop__title">(3.5) 1100 reviews</h4>
                                    </div> -->
                <!-- end review -->

                <div class="filter__form-group">
                  <div class="form__select-wrap">
                    <div class="form__select" style="--width: 146px">
                      Số lượng
                    </div>
                    <div class="form__select">${product.stock}</div>
                  </div>
                </div>
                <div class="filter__form-group">
                  <div class="form__tags">
                    <button class="form__tag prod-info__tag">Small</button>
                    <button class="form__tag prod-info__tag">Medium</button>
                    <button class="form__tag prod-info__tag">Large</button>
                  </div>
                </div>
              </div>
              <div class="col-7 col-xxl-6 col-xl-12">
                <div class="prod-props">
                  <div class="prod-prop">
                    <img
                      src="/client/assets/icons/document.svg"
                      alt=""
                      class="prod-prop__icon icon"
                    />
                    <h4 class="prod-prop__title">Compare</h4>
                  </div>
                  <div class="prod-prop">
                    <img
                      src="/client/assets/icons/buy.svg"
                      alt=""
                      class="prod-prop__icon icon"
                    />
                    <div>
                      <h4 class="prod-prop__title">Delivery</h4>
                      <p class="prod-prop__desc">From $6 for 1-3 days</p>
                    </div>
                  </div>
                  <div class="prod-prop">
                    <img
                      src="/client/assets/icons/bag.svg"
                      alt=""
                      class="prod-prop__icon icon"
                    />
                    <div>
                      <h4 class="prod-prop__title">Pickup</h4>
                      <p class="prod-prop__desc">Out of 2 store, today</p>
                    </div>
                  </div>
                  <div class="prod-info__card">
                    <div class="prod-info__row">
                      <span class="prod-info__price">$500.00</span>
                      <span class="prod-info__tax">10%</span>
                    </div>
                    <p class="prod-info__total-price">
                      <c:choose>
                        <c:when test="${product.price != null}">
                          <c:if test="${product.price % 1 != 0}">
                            <fmt:formatNumber
                              value="${product.price}"
                              pattern="#,##0.000"
                            />
                            đ
                          </c:if>
                          <c:if test="${product.price % 1 == 0}">
                            <fmt:formatNumber
                              value="${product.price}"
                              pattern="#,##0"
                            />
                            đ
                          </c:if>
                        </c:when>
                      </c:choose>
                    </p>
                    <div class="prod-info__row">
                      <form
                        action="/add-product-to-cart/${product.product_id}"
                        method="post"
                        class="form"
                      >
                        <input
                          type="hidden"
                          name="${_csrf.parameterName}"
                          value="${_csrf.token}"
                        />
                        <a type="submit" class="btn btn--primary submit" style="cursor: pointer;">
                          Thêm vào giỏ hàng
                        </a>
                      </form>

                      <!-- <button class="like-btn prod-info__like-btn">
                          <img
                            src="/client/assets/icons/heart.svg"
                            alt=""
                            class="like-btn__icon icon"
                          />
                          <img
                            src="/client/assets/icons/heart-red.svg"
                            alt=""
                            class="like-btn__icon--liked"
                          />
                        </button> -->
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>

    <!-- Product content -->
    <div class="product-container">
      <div class="prod-tab js-tabs">
        <ul class="prod-tab__list">
          <li class="prod-tab__item prod-tab__item--current">Mô tả</li>
          <li class="prod-tab__item">Bình luận (1100)</li>
          <li class="prod-tab__item">Sản phẩm liên quan</li>
        </ul>
        <div class="prod-tab__contents">
          <div class="prod-tab__content prod-tab__content--current">
            <div class="row">
              <div class="col-8 col-xl-10 col-lg-12">
                <div class="text-content prod-tab__text-content">
                  ${product.description}
                </div>
              </div>
            </div>
          </div>
          <div class="prod-tab__content">
            <div class="prod-content">
              <h2 class="prod-content__heading">
                What our customers are saying
              </h2>
              <div class="row row-cols-3 gx-lg-2 row-cols-md-1 gy-md-3">
                <!-- Review card 1 -->
                <div class="col">
                  <div class="review-card">
                    <div class="review-card__content">
                      <img
                        src="/client/assets/img/avatar/avatar-1.png"
                        alt=""
                        class="review-card__avatar"
                      />
                      <div class="review-card__info">
                        <h4 class="review-card__title">Jakir Hussen</h4>
                        <p class="review-card__desc">
                          Great product, I love this Coffee Beans
                        </p>
                      </div>
                    </div>
                    <div class="review-card__rating">
                      <div class="review-card__star-list">
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star-half.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star-blank.svg"
                          alt=""
                          class="review-card__star"
                        />
                      </div>
                      <span class="review-card__rating-title"
                        >(3.5) Review</span
                      >
                    </div>
                  </div>
                </div>

                <!-- Review card 2 -->
                <div class="col">
                  <div class="review-card">
                    <div class="review-card__content">
                      <img
                        src="/client/assets/img/avatar/avatar-2.png"
                        alt=""
                        class="review-card__avatar"
                      />
                      <div class="review-card__info">
                        <h4 class="review-card__title">Jubed Ahmed</h4>
                        <p class="review-card__desc">
                          Awesome Coffee, I love this Coffee Beans
                        </p>
                      </div>
                    </div>
                    <div class="review-card__rating">
                      <div class="review-card__star-list">
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star-half.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star-blank.svg"
                          alt=""
                          class="review-card__star"
                        />
                      </div>
                      <span class="review-card__rating-title"
                        >(3.5) Review</span
                      >
                    </div>
                  </div>
                </div>

                <!-- Review card 3 -->
                <div class="col">
                  <div class="review-card">
                    <div class="review-card__content">
                      <img
                        src="/client/assets/img/avatar/avatar-3.png"
                        alt=""
                        class="review-card__avatar"
                      />
                      <div class="review-card__info">
                        <h4 class="review-card__title">Delwar Hussain</h4>
                        <p class="review-card__desc">
                          Great product, I like this Coffee Beans
                        </p>
                      </div>
                    </div>
                    <div class="review-card__rating">
                      <div class="review-card__star-list">
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star-half.svg"
                          alt=""
                          class="review-card__star"
                        />
                        <img
                          src="/client/assets/icons/star-blank.svg"
                          alt=""
                          class="review-card__star"
                        />
                      </div>
                      <span class="review-card__rating-title"
                        >(3.5) Review</span
                      >
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="prod-tab__content">
            <div class="prod-content">
              <h2 class="prod-content__heading">
                Similar items you might like
              </h2>
              <div
                class="row row-cols-6 row-cols-xl-4 row-cols-lg-3 row-cols-md-2 row-cols-sm-1 g-2"
              >
                <!-- Product card 1 -->
                <div class="col">
                  <article class="product-card">
                    <div class="product-card__img-wrap">
                      <a href="/client/product-detail.html">
                        <img
                          src="/client/assets/img/product/item-1.png"
                          alt=""
                          class="product-card__thumb"
                        />
                      </a>
                      <button class="like-btn product-card__like-btn">
                        <img
                          src="/client/assets/icons/heart.svg"
                          alt=""
                          class="like-btn__icon icon"
                        />
                        <img
                          src="/client/assets/icons/heart-red.svg"
                          alt=""
                          class="like-btn__icon--liked"
                        />
                      </button>
                    </div>
                    <h3 class="product-card__title">
                      <a href="/client/product-detail.html"
                        >Coffee Beans - Espresso Arabica and Robusta Beans</a
                      >
                    </h3>
                    <p class="product-card__brand">Lavazza</p>
                    <div class="product-card__row">
                      <span class="product-card__price">$47.00</span>
                      <img
                        src="/client/assets/icons/star.svg"
                        alt=""
                        class="product-card__star"
                      />
                      <span class="product-card__score">4.3</span>
                    </div>
                  </article>
                </div>

                <!-- Product card 2 -->
                <div class="col">
                  <article class="product-card">
                    <div class="product-card__img-wrap">
                      <a href="/client/product-detail.html">
                        <img
                          src="/client/assets/img/product/item-2.png"
                          alt=""
                          class="product-card__thumb"
                        />
                      </a>
                      <button class="like-btn product-card__like-btn">
                        <img
                          src="/client/assets/icons/heart.svg"
                          alt=""
                          class="like-btn__icon icon"
                        />
                        <img
                          src="/client/assets/icons/heart-red.svg"
                          alt=""
                          class="like-btn__icon--liked"
                        />
                      </button>
                    </div>
                    <h3 class="product-card__title">
                      <a href="/client/product-detail.html"
                        >Lavazza Coffee Blends - Try the Italian Espresso</a
                      >
                    </h3>
                    <p class="product-card__brand">Lavazza</p>
                    <div class="product-card__row">
                      <span class="product-card__price">$53.00</span>
                      <img
                        src="/client/assets/icons/star.svg"
                        alt=""
                        class="product-card__star"
                      />
                      <span class="product-card__score">3.4</span>
                    </div>
                  </article>
                </div>

                <!-- Product card 3 -->
                <div class="col">
                  <article class="product-card">
                    <div class="product-card__img-wrap">
                      <a href="/client/product-detail.html">
                        <img
                          src="/client/assets/img/product/item-3.png"
                          alt=""
                          class="product-card__thumb"
                        />
                      </a>
                      <button
                        class="like-btn like-btn--liked product-card__like-btn"
                      >
                        <img
                          src="/client/assets/icons/heart.svg"
                          alt=""
                          class="like-btn__icon icon"
                        />
                        <img
                          src="/client/assets/icons/heart-red.svg"
                          alt=""
                          class="like-btn__icon--liked"
                        />
                      </button>
                    </div>
                    <h3 class="product-card__title">
                      <a href="/client/product-detail.html"
                        >Lavazza - Caffè Espresso Black Tin - Ground coffee</a
                      >
                    </h3>
                    <p class="product-card__brand">Welikecoffee</p>
                    <div class="product-card__row">
                      <span class="product-card__price">$99.99</span>
                      <img
                        src="/client/assets/icons/star.svg"
                        alt=""
                        class="product-card__star"
                      />
                      <span class="product-card__score">5.0</span>
                    </div>
                  </article>
                </div>

                <!-- Product card 4 -->
                <div class="col">
                  <article class="product-card">
                    <div class="product-card__img-wrap">
                      <a href="/client/product-detail.html">
                        <img
                          src="/client/assets/img/product/item-4.png"
                          alt=""
                          class="product-card__thumb"
                        />
                      </a>
                      <button class="like-btn product-card__like-btn">
                        <img
                          src="/client/assets/icons/heart.svg"
                          alt=""
                          class="like-btn__icon icon"
                        />
                        <img
                          src="/client/assets/icons/heart-red.svg"
                          alt=""
                          class="like-btn__icon--liked"
                        />
                      </button>
                    </div>
                    <h3 class="product-card__title">
                      <a href="/client/product-detail.html"
                        >Qualità Oro Mountain Grown - Espresso Coffee Beans</a
                      >
                    </h3>
                    <p class="product-card__brand">Lavazza</p>
                    <div class="product-card__row">
                      <span class="product-card__price">$38.65</span>
                      <img
                        src="/client/assets/icons/star.svg"
                        alt=""
                        class="product-card__star"
                      />
                      <span class="product-card__score">4.4</span>
                    </div>
                  </article>
                </div>

                <!-- Product card 5 -->
                <div class="col">
                  <article class="product-card">
                    <div class="product-card__img-wrap">
                      <a href="/client/product-detail.html">
                        <img
                          src="/client/assets/img/product/item-1.png"
                          alt=""
                          class="product-card__thumb"
                        />
                      </a>
                      <button class="like-btn product-card__like-btn">
                        <img
                          src="/client/assets/icons/heart.svg"
                          alt=""
                          class="like-btn__icon icon"
                        />
                        <img
                          src="/client/assets/icons/heart-red.svg"
                          alt=""
                          class="like-btn__icon--liked"
                        />
                      </button>
                    </div>
                    <h3 class="product-card__title">
                      <a href="/client/product-detail.html"
                        >Coffee Beans - Espresso Arabica and Robusta Beans</a
                      >
                    </h3>
                    <p class="product-card__brand">Lavazza</p>
                    <div class="product-card__row">
                      <span class="product-card__price">$47.00</span>
                      <img
                        src="/client/assets/icons/star.svg"
                        alt=""
                        class="product-card__star"
                      />
                      <span class="product-card__score">4.3</span>
                    </div>
                  </article>
                </div>

                <!-- Product card 6 -->
                <div class="col">
                  <article class="product-card">
                    <div class="product-card__img-wrap">
                      <a href="/client/product-detail.html">
                        <img
                          src="/client/assets/img/product/item-2.png"
                          alt=""
                          class="product-card__thumb"
                        />
                      </a>
                      <button class="like-btn product-card__like-btn">
                        <img
                          src="/client/assets/icons/heart.svg"
                          alt=""
                          class="like-btn__icon icon"
                        />
                        <img
                          src="/client/assets/icons/heart-red.svg"
                          alt=""
                          class="like-btn__icon--liked"
                        />
                      </button>
                    </div>
                    <h3 class="product-card__title">
                      <a href="/client/product-detail.html"
                        >Lavazza Coffee Blends - Try the Italian Espresso</a
                      >
                    </h3>
                    <p class="product-card__brand">Lavazza</p>
                    <div class="product-card__row">
                      <span class="product-card__price">$53.00</span>
                      <img
                        src="/client/assets/icons/star.svg"
                        alt=""
                        class="product-card__star"
                      />
                      <span class="product-card__score">3.4</span>
                    </div>
                  </article>
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
