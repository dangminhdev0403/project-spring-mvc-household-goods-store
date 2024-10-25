<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />

<!-- end Header -->

<!-- MAIN -->
<main class="container home">
  <!-- Slideshow -->
  <div class="home__container">
    <div class="slideshow">
      <div class="slideshow__inner">
        <div class="slideshow__item">
          <a href="#!" class="slideshow__link">
            <picture>
              <source
                media="(max-width: 767.98px)"
                srcset="/client/assets/img/slideshow/item-1-md.png"
              />
              <img
                src="/client/assets/img/slideshow/item-1.png"
                alt=""
                class="slideshow__img"
              />
            </picture>
          </a>
        </div>
      </div>

      <div class="slideshow__page">
        <span class="slideshow__num">1</span>
        <span class="slideshow__slider"></span>
        <span class="slideshow__num">5</span>
      </div>
    </div>
  </div>

  <!-- Browse Products -->
  <section class="home__container">
    <div class="home__row">
      <h2 class="home__heading">Danh sách sản phẩm</h2>
    </div>

    <div class="row row-cols-5 row-cols-lg-2 row-cols-sm-1 g-3">
      <!--list Product -->
      <!-- tĩnh  -->
      <!-- <c:forEach var="product" items="${listProduct}">
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
</c:forEach> -->
      <!-- động -->
      <c:forEach var="product" items="${listProduct}">
        <div class="col">
          <article class="product-card">
            <div class="product-card__img-wrap">
              <a href="/product/${product.product_id}">
                <img
                  src="/upload/products/${product.productImages[0].name}"
                  alt="${product.productImages[0].name}"
                  class="product-card__thumb"
                />
              </a>
            </div>
            <h3 class="product-card__title">
              <a href="/product/${product.product_id}"> ${product.name}</a>
            </h3>
            <p class="product-card__brand">${product.category.name}</p>
            <div class="product-card__row">
              <span class="product-card__price">
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
              </span>

              <img
                src="/client/assets/icons/star.svg"
                alt=""
                class="product-card__star"
              />
              <span class="product-card__score">4.3</span>
            </div>
          </article>
        </div>
      </c:forEach>
    </div>
  </section>
</main>

<!-- Footer -->

<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
