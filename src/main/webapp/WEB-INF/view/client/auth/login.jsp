<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đăng nhập | Grocery Mart</title>

    <!-- Favicon -->
    <link
      rel="apple-touch-icon"
      sizes="76x76"
      href="client/assets/favicon/apple-touch-icon.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="32x32"
      href="client/assets/favicon/favicon-32x32.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="16x16"
      href="client/assets/favicon/favicon-16x16.png"
    />
    <link rel="manifest" href="client/assets/favicon/site.webmanifest" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />
    <meta name="msapplication-TileColor" content="#da532c" />
    <meta name="theme-color" content="#ffffff" />

    <!-- Fonts -->
    <link rel="stylesheet" href="client/assets/fonts/stylesheet.css" />

    <!-- Styles -->
    <link rel="stylesheet" href="client/assets/css/main.css" />

    <!-- Scripts -->
    <script src="client/assets/js/scripts.js"></script>
    <style>
      .alert {
        position: relative;
        padding: 1rem 1rem;
        margin-bottom: 1rem;
        border: 1px solid transparent;
        border-radius: 0.25rem;
      }
      .alert-danger {
        text-align: center;
        color: #842029;
        background-color: #f8d7da;
        border-color: #f5c2c7;
      }

      .hidden {
        display: none !important;
      }
      .swal-footer {
        display: flex;
        flex-direction: row-reverse;
        justify-content: center;
      }
      .btn-success {
        background: #31ce36 !important;
        border-color: #31ce36 !important;
      }

      .btn-danger {
        background: #f25961 !important;
        border-color: #f25961 !important;
        color: #fff;
      }
      .sub-menu--not-main {
        height: 100%;
      }
    </style>
  </head>
  <body>
    <main class="auth">
      <!-- Giới thiệu đăng nhập -->
      <div class="auth__intro d-md-none">
        <img
          src="client/assets/img/auth/intro.svg"
          alt=""
          class="auth__intro-img"
        />
        <p class="auth__intro-text">
          Giá trị thương hiệu sang trọng tốt nhất, sản phẩm chất lượng cao và
          dịch vụ đổi mới
        </p>
      </div>

      <!-- Nội dung đăng nhập -->
      <div class="auth__content">
        <div class="auth__content-inner">
          <a href="/" class="logo">
            <img
              src="client/assets/icons/logo.svg"
              alt="Chợ Gia Dụng"
              class="logo__img"
            />
            <h2 class="logo__title">Chợ Gia Dụng</h2>
          </a>
          <h1 class="auth__heading">Chào mừng bạn trở lại!</h1>
          <p class="auth__desc">
            "Chúng tôi rất vui khi bạn trở lại! Bạn có quyền truy cập vào tất cả
            thông tin trước đây của mình."
          </p>
          <form
            action="/login"
            method="post"
            class="form auth__form"
            id="form-login"
          >
            <c:if
              test="${param.error != null }"
            >
              <c:if test="${param.error eq 'not-found' || param.error eq  'unknown-error'}">
                <p
                  class="form__error"
                  style="display: block; font-size: 1.8rem; text-align: center"
                >
                  Thông tin đăng nhập không chính xác
                </p>
                
              </c:if>
              <c:if test="${param.error eq 'locked' }">
                <p
                  class="form__error"
                  style="display: block; font-size: 1.8rem; text-align: center"
                >
                  Tài khoản của bạn đã bị vô hiệu hóa.
                </p>
              </c:if>
            </c:if>

            <c:if test="${param.logout != null or  param.expired != null}">
              <p
                class="form__success"
                style="
                  display: block;
                  font-size: 1.8rem;
                  color: rgb(22, 192, 22);
                "
              >
                Đăng xuất thành công!
              </p>
            </c:if>
            <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />

            <div class="form__group has-error">
              <div class="form__text-input">
                <input
                  type="text"
                  name="username"
                  id="email"
                  placeholder="Nhập email"
                  class="form__input"
                  autocomplete
                  autofocus
                />
                <img
                  src="client/assets/icons/message.svg"
                  alt=""
                  class="form__input-icon"
                />
                <img
                  src="client/assets/icons/form-error.svg"
                  alt=""
                  class="form__input-icon-error"
                />
              </div>
            </div>
            <div class="form__group">
              <div class="form__text-input">
                <input
                  type="password"
                  name="password"
                  id="password"
                  placeholder="Nhập Mật khẩu"
                  class="form__input pass-input"
                />
                <i
                  class="fas fa-eye togglePassword form__input-icon"
                  style="cursor: pointer; font-size: 2rem"
                ></i>
              </div>
            </div>
            <div class="form__group form__group--inline">
              <a
                href="/forgot-pass"
                style="font-size: 2rem"
                class="auth__link form__pull-right"
                >Quên mật khẩu?</a
              >
            </div>
            <div class="form__group auth__btn-group">
              <button class="btn btn--primary auth__btn">Đăng Nhập</button>
            </div>
          </form>

          <p class="auth__text">
            Chưa có tài khoản?
            <a href="/register" class="auth__link auth__text-link">Đăng Ký</a>
          </p>
        </div>
      </div>
    </main>
    <script>
      window.dispatchEvent(new Event("template-loaded"));
    </script>
    <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
