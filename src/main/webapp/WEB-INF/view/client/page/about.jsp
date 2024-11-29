<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->

<main class="affiliate-page">
  <div class="blur-circle blur-circle-1"></div>
  <div class="blur-circle blur-circle-2"></div>

  <section class="hero" id="home">
    <div class="container2 hero-content">
      <h1>Kiếm tiền không giới hạn cùng chúng tôi</h1>
      <p>
        Tham gia cộng đồng affiliate hàng đầu Việt Nam và tận hưởng commission
        hấp dẫn cùng hệ thống hỗ trợ chuyên nghiệp
      </p>
      <a href="/affiliates" class="btn" style="cursor: pointer; z-index: 1; position: relative;">Bắt đầu ngay</a>
    </div>
  </section>

  <div class="container2">
    <div class="stats ">
      <div class="stat-card">
        <div class="stat-number">30%</div>
        <div class="stat-label">Hoa hồng</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">24/7</div>
        <div class="stat-label">Hỗ trợ</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">10K+</div>
        <div class="stat-label">Đối tác</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">1M+</div>
        <div class="stat-label">Đơn hàng</div>
      </div>
    </div>
  </div>

  <section class="benefits" id="benefits">
    <div class="container2">
      <h2 class="section-title">Lợi ích khi tham gia</h2>
      <div class="benefit-cards">
        <div class="benefit-card">
          <i class="fas fa-percentage benefit-icon"></i>
          <h3>Hoa hồng cao</h3>
          <p>Nhận đến 30% hoa hồng cho mỗi đơn hàng thành công</p>
        </div>
        <div class="benefit-card">
          <i class="fas fa-money-bill-wave benefit-icon"></i>
          <h3>Thanh toán nhanh</h3>
          <p>Thanh toán đúng hạn vào ngày 15 hàng tháng</p>
        </div>
        <div class="benefit-card">
          <i class="fas fa-headset benefit-icon"></i>
          <h3>Hỗ trợ 24/7</h3>
          <p>Đội ngũ hỗ trợ chuyên nghiệp luôn sẵn sàng giúp đỡ</p>
        </div>
      </div>
    </div>
  </section>

  <section class="products" id="products">
    <div class="container2">
      <h2 class="section-title">Sản phẩm nổi bật</h2>
  <div class="product-grid">

        <div class="product-card">
          <img
            src="https://via.placeholder.com/400x300"
            alt="Product 1"
            class="product-image"
          />
          <div class="product-info">
            <h3 class="product-title">Sản phẩm cao cấp 1</h3>
            <span class="commission">Hoa hồng: 30%</span>
            <p>Mô tả chi tiết về sản phẩm và các ưu điểm nổi bật</p>
            <a href="#" class="btn">Lấy link affiliate</a>
          </div>
        </div>
        <div class="product-card">
          <img
            src="https://via.placeholder.com/400x300"
            alt="Product 2"
            class="product-image"
          />
          <div class="product-info">
            <h3 class="product-title">Sản phẩm cao cấp 2</h3>
            <span class="commission">Hoa hồng: 25%</span>
            <p>Mô tả chi tiết về sản phẩm và các ưu điểm nổi bật</p>
            <a href="#" class="btn">Lấy link affiliate</a>
          </div>
        </div>
        <div class="product-card">
          <img
            src="https://via.placeholder.com/400x300"
            alt="Product 3"
            class="product-image"
          />
          <div class="product-info">
            <h3 class="product-title">Sản phẩm cao cấp 3</h3>
            <span class="commission">Hoa hồng: 20%</span>
            <p>Mô tả chi tiết về sản phẩm và các ưu điểm nổi bật</p>
            <a href="#" class="btn">Lấy link affiliate</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <script>
    // Animations
    anime({
      targets: ".hero-content",
      translateY: [50, 0],
      opacity: [0, 1],
      duration: 1000,
      easing: "easeOutExpo",
    });

    anime({
      targets: ".stat-card",
      translateY: [50, 0],
      opacity: [0, 1],
      delay: anime.stagger(100),
      duration: 800,
      easing: "easeOutExpo",
    });

    anime({
      targets: ".benefit-card",
      translateY: [50, 0],
      opacity: [0, 1],
      delay: anime.stagger(100),
      duration: 800,
      easing: "easeOutExpo",
    });

    // Dark mode toggle
   

    // Smooth scroll
    document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
      anchor.addEventListener("click", function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute("href")).scrollIntoView({
          behavior: "smooth",
        });
      });
    });
  </script>
</main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
