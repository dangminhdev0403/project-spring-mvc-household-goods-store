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
          <div class="col">
            <article class="product-card">
              <div class="product-card__img-wrap">
                <a href="/product/${product.product_id}">
                  <img
                    src="${product.productImages[0].url}"
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
      <div class="pagination d-flex justify-content-center mt-5">
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
