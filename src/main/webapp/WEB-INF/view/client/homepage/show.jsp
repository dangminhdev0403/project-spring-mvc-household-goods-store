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

          <div class="banner-container">
        <div class="banner">
            <img src="https://res.cloudinary.com/dwjqosrrk/image/upload/f_auto,q_auto/icjeytyr2ccew4uoxyvx" alt="Đồ gia dụng" class="banner-image">
            <div class="banner-content">
                <h1 class="banner-title">Đồ Gia Dụng Cao Cấp</h1>
                <p class="banner-subtitle">Nâng tầm không gian sống của bạn với những sản phẩm chất lượng</p>
                <button class="banner-button">Khám phá ngay</button>
            </div>
            <div class="floating-items">
                <div class="floating-item"></div>
                <div class="floating-item"></div>
                <div class="floating-item"></div>
            </div>
        </div>
    </div>

    <script>
        // Animation cho các phần tử
        anime({
            targets: '.banner-title',
            opacity: [0, 1],
            translateY: [30, 0],
            duration: 1000,
            easing: 'easeOutExpo',
            delay: 300
        });

        anime({
            targets: '.banner-subtitle',
            opacity: [0, 1],
            translateY: [30, 0],
            duration: 1000,
            easing: 'easeOutExpo',
            delay: 500
        });

        anime({
            targets: '.banner-button',
            opacity: [0, 1],
            translateY: [30, 0],
            duration: 1000,
            easing: 'easeOutExpo',
            delay: 700
        });

        // Animation cho hình ảnh
        anime({
            targets: '.banner-image',
            scale: [1.1, 1],
            duration: 3000,
            easing: 'easeOutExpo'
        });

        // Animation cho các item nổi
        const floatingItems = document.querySelectorAll('.floating-item');
        floatingItems.forEach((item, index) => {
            const randomX = Math.random() * 80 + 10;
            const randomY = Math.random() * 80 + 10;
            
            item.style.left = `${randomX}%`;
            item.style.top = `${randomY}%`;

            anime({
                targets: item,
                translateX: function() {
                    return anime.random(-20, 20);
                },
                translateY: function() {
                    return anime.random(-20, 20);
                },
                scale: [1, 1.2],
                opacity: [0.5, 0.2],
                duration: 3000,
                direction: 'alternate',
                loop: true,
                easing: 'easeInOutSine',
                delay: index * 200
            });
        });
    </script>


          <!-- <a href="#!" class="slideshow__link">
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
          </a> -->
        </div>
      </div>

    
    </div>
  </div>

  <!-- Browse Products -->
  <section class="home__container">
    <div class="home__row">
      <h2 class="home__heading">
        Danh sách sản phẩm
        <c:if test="${not empty nameProduct}">
          với từ khoá : ${nameProduct}
        </c:if>
      </h2>
    </div>

    <c:if test="${empty listProduct}">
      <div class="row col-12">
        <h1 class="cart-info__heading" style="color: #c90504">
          Không có sản phẩm nào được tìm thấy.
        </h1>
      </div>
    </c:if>
    <c:if test="${totalPages >= 1 }">
      <div class="row row-cols-5 row-cols-lg-2 row-cols-sm-1 g-3">
        <c:forEach var="product" items="${listProduct}">
          <div class="col detail-sp"  >
            <article class="product-card" style="cursor: pointer;">
              <div class="product-card__img-wrap">
                <a href="/product/${product.slug}-${product.product_id}">
                  <img
                    src="${product.productImages[0].url}"
                    alt="${product.productImages[0].name}"
                    class="product-card__thumb"
                  />
                </a>
              </div>
              <h3 class="product-card__title">
                <a href="/product/${product.slug}-${product.product_id}">
                  ${product.name}</a
                >
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
      <div
        class="pagination d-flex justify-content-center mt-5"
        data-total-page="${totalPages}"
      >
        <c:if test="${ currentPage > 1 }">
          <li class="page-item">
            <a
              class="disabled page-link"
              href="/?page=${currentPage -1 }"
              aria-label="Previous"
            >
              <span aria-hidden="true">«</span>
            </a>
          </li>
        </c:if>

        <c:forEach begin="0" end="${totalPages -1}" varStatus="loop">
          <li class="page-item">
            <a
              class="page-link ${(loop.index+1) eq currentPage ? 'active' : ''}"
              href="/?page=${loop.index+1}"
            >
              ${loop.index+1}
            </a>
          </li>
        </c:forEach>

        <c:if test="${ currentPage != totalPages  }">
          <li class="page-item">
            <a
              class="disabled page-link"
              href="/?page=${currentPage +1 }"
              aria-label="Next"
            >
              <span aria-hidden="true">»</span>
            </a>
          </li>
        </c:if>
      </div>
    </c:if>
  </section>
</main>

<!-- Footer -->

<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
