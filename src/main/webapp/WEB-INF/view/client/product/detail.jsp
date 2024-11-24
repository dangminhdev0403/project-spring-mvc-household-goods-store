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
          <a
            href="/product/${product.slug}-${product.product_id}"
            class="breadcrumbs__link"
          >
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
              <div class="prod-preview__item">
                <img
                  src="${product.productImages[0].url}"
                  alt=""
                  class="prod-preview__img"
                />
              </div>
            </div>
            <div class="prod-preview__thumbs">
              <c:forEach var="image" items="${product.productImages}">
                <img
                  src="${image.url}"
                  alt="${image.name}"
                  class="prod-preview__thumb-img product.productImages"
                />
              </c:forEach>
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
                      Tình trạng
                    </div>
                    <div class="form__select">
                      <c:if test="${product.stock <= 0}"> Hết hàng </c:if>
                      <c:if test="${product.stock > 0}"> Còn hàng </c:if>
                    </div>
                  </div>
                </div>
                <div class="filter__form-group">
                  <div class="form__tags"></div>
                  <div
                    class="cart-item__input"
                    style="display: inline-flex; margin-top: 3rem"
                  >
                    <button class="cart-item__input-btn" id="decrease">
                      <img
                        class="icon"
                        src="/client/assets/icons/minus.svg"
                        alt=""
                      />
                    </button>
                    <span id="quantity">1</span>
                    <button class="cart-item__input-btn" id="increase">
                      <img
                        class="icon"
                        src="/client/assets/icons/plus.svg"
                        alt=""
                      />
                    </button>
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
                    <h4 class="prod-prop__title">Nổi bật</h4>
                  </div>
                  <div class="prod-prop">
                    <img
                      src="/client/assets/icons/buy.svg"
                      alt=""
                      class="prod-prop__icon icon"
                    />
                    <div>
                      <h4 class="prod-prop__title">Giao hàng tận nơi</h4>
                      <p class="prod-prop__desc">
                        Giao tận nhà, tiện lợi và nhanh chóng.
                      </p>
                    </div>
                  </div>
                  <div class="prod-prop">
                    <img
                      src="/client/assets/icons/bag.svg"
                      alt=""
                      class="prod-prop__icon icon"
                    />
                    <div>
                      <h4 class="prod-prop__title">Tuỳ chọn thanh toán</h4>
                      <p class="prod-prop__desc">
                        Có nhiều lựa chọn thanh toán linh hoạt.
                      </p>
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
                        class="form"
                        
                      >
                        <input
                          type="hidden"
                          name="quantity"
                          value="1"
                          id="quantity-submit"
                        />
                        <a
                          type="submit"
                          class="btn btn--primary add-product"
                          style="cursor: pointer"
                        >
                          Thêm vào giỏ hàng
                        </a>

                        <a
                          href="/buy-now/${product.slug}-${product.product_id}"
                          class="btn btn--primary buy-product-now"
                          style="
                            cursor: pointer;
                            margin-top: 1rem;
                            background-color: #fa5e5e;
                          "
                        >
                          Mua ngay
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
          <!-- <li class="prod-tab__item">Bình luận (1100)</li> -->
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
          <!-- comment -->
          <!-- end comment -->
          <div class="prod-tab__content">
            <div class="prod-content">
              <h2 class="prod-content__heading">Có thể bạn quan tâm</h2>
              <div
                class="row row-cols-6 row-cols-xl-4 row-cols-lg-3 row-cols-md-2 row-cols-sm-1 g-2"
              >
                <c:forEach
                  begin="0"
                  end="5"
                  var="pr"
                  items="${product.category.products}"
                >
                  <!-- Product card 1 -->
                  <div class="col">
                    <article class="product-card">
                      <div class="product-card__img-wrap">
                        <a href="/product/${pr.product_id}">
                          <img
                            src="${pr.productImages[0].url}"
                            alt="${pr.name}"
                            class="product-card__thumb"
                          />
                        </a>
                      </div>
                      <h3 class="product-card__title">
                        <a href="/product/${pr.product_id}"> ${pr.name}</a>
                      </h3>
                      <p class="product-card__brand">${pr.category.name}</p>
                      <div class="product-card__row">
                        <span class="product-card__price format-price"
                          >${product.price}</span
                        >
                      </div>
                    </article>
                  </div>
                </c:forEach>
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
