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

  <section class="guide-section" id="guide">
    <div class="container">
        <h2 class="section-title" style="background: var(--primary); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
            Hướng Dẫn Tham Gia
        </h2>
        
        <div class="guide-container">
            <!-- Registration Guide -->
            <div class="guide-block glass-morphism">
                <h3 class="guide-title">
                    <i class="fas fa-user-plus" style="color: var(--accent);"></i>
                    Hướng Dẫn Đăng Ký
                </h3>
                <div class="steps-container">
                    <div class="step-card glass-card">
                        <div class="step-number gradient-bg">1</div>
                        <div class="step-content">
                            <h4>Đăng Ký Tài Khoản</h4>
                            <p>Điền thông tin cá nhân và tạo tài khoản affiliate của bạn</p>
                            <c:if test="${sessionScope.role == null}">
                              <a href="/affiliates" class="btn-step gradient-bg">Đăng Ký Ngay</a>

                            </c:if>
                            <c:if test="${sessionScope.role != null}">
                              <a href="#" class="btn-step gradient-bg">Đẵ đăng ký</a>

                            </c:if>
                           
                        </div>
                    </div>

                    <div class="step-card glass-card">
                        <div class="step-number gradient-bg">2</div>
                        <div class="step-content">
                            <h4>Xác Thực Thông Tin</h4>
                            <p>Xác minh email và số điện thoại của bạn để đảm bảo an toàn  sử dụng dịch vụ.</p>
                            <c:choose>
                              <c:when test="${not empty isEnable && isEnable == 'true'}">
                                  <a href="#" class="btn-step gradient-bg">Đã Xác Thực</a>
                              </c:when>
                              <c:otherwise>
                                  <a href="/profile" class="btn-step gradient-bg">Xác Thực Ngay</a>
                              </c:otherwise>
                          </c:choose>
                        </div>
                    </div>

                    <div class="step-card glass-card">
                        <div class="step-number gradient-bg">3</div>
                        <div class="step-content">
                            <h4>Bắt đầu kiếm thu nhập</h4>
                            <p>Hãy khám phá ngay các cơ hội kiếm thu nhập hấp dẫn!</p>
                            <a href="#" class="btn-step gradient-bg">Hoàn Tất</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Operation Guide -->
            <div class="guide-block glass-morphism">
                <h3 class="guide-title">
                    <i class="fas fa-cogs" style="color: var(--accent);"></i>
                    Hướng Dẫn Hoạt Động
                </h3>
                <div class="operation-cards">
                    <div class="operation-card glass-card">
                        <i class="fas fa-link"></i>
                        <h4>Lấy Link Affiliate</h4>
                        <p> Lấy link affiliate trực tiếp từ trang sản phẩm bất kì</p>
                        <div class="card-progress">
                            <div class="progress-bar"></div>
                        </div>
                    </div>

                    <div class="operation-card glass-card">
                        <i class="fas fa-share-alt"></i>
                        <h4>Chia Sẻ Link</h4>
                        <p>Chia sẻ link qua mạng xã hội, blog, website...</p>
                        <div class="card-progress">
                            <div class="progress-bar"></div>
                        </div>
                    </div>

                    <div class="operation-card glass-card">
                        <i class="fas fa-chart-line"></i>
                        <h4>Theo Dõi Hiệu Quả</h4>
                        <p>Kiểm tra số liệu thống kê và doanh thu real-time</p>
                        <div class="card-progress">
                            <div class="progress-bar"></div>
                        </div>
                    </div>

                    <div class="operation-card glass-card">
                        <i class="fas fa-wallet"></i>
                        <h4>Nhận Hoa Hồng</h4>
                        <p>Nhận thanh toán tự động vào ngày 15 hàng tháng</p>
                        <div class="card-progress">
                            <div class="progress-bar"></div>
                        </div>
                    </div>
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
