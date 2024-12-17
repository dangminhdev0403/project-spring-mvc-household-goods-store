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
    <title>Đăng ký | Grocery Mart</title>

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

    <style>
      .form__group.invalid .form__text-input {
        border-color: #ed4337;
        background: rgba(237, 67, 55, 0.1);
      }
      .form__error {
        font-size: 1.8rem;
      }
    </style>
  </head>
  <body>
    <main class="auth">
      <!-- Auth intro -->
      <div class="auth__intro">
        <a href="/" class="logo auth__intro-logo d-none d-md-flex">
          <img
            src="client/assets/icons/logo.svg"
            alt="Thế Giới Gia Dụng"
            class="logo__img"
          />
          <h1 class="logo__title">Thế Giới Gia Dụng</h1>
        </a>
        <img
          src="client/assets/img/auth/intro.svg"
          alt=""
          class="auth__intro-img"
        />
        <p class="auth__intro-text">
          Giá trị của thương hiệu cao cấp, sản phẩm chất lượng cao và dịch vụ
          sáng tạo.
        </p>
        <button
          class="auth__intro-next d-none d-md-flex js-toggle"
          toggle-target="#auth-content"
        >
          <img src="client/assets/img/auth/intro-arrow.svg" alt="" />
        </button>
      </div>

      <!-- Auth content -->
      <div id="auth-content" class="auth__content hide">
        <div class="auth__content-inner">
          <a href="/" class="logo">
            <img
              src="client/assets/icons/logo.svg"
              alt="Thế Giới Gia Dụng"
              class="logo__img"
            />
            <h1 class="logo__title">Thế Giới Gia Dụng</h1>
          </a>
          <h1 class="auth__heading">Đăng Ký</h1>
          <p class="auth__desc">
            Tạo tài khoản của bạn và mua sắm như một chuyên gia để tiết kiệm.
          </p>
          <form:form
            action="/register"
            modelAttribute="registerUser"
            method="post"
            class="form auth__form"
            id="form-register"
          >
            <div class="form__group">
              <div class="form__text-input">
                <form:input
                  type="text"
                  name="resEmail"
                  id="restLast"
                  placeholder="Nhập Họ"
                  class="form__input"
                  path="lastName"
                />
                <img
                  src="client/assets/icons/message.svg"
                  alt=""
                  class="form__input-icon"
                />
              </div>
            </div>

            <div class="form__group">
              <div class="form__text-input">
                <form:input
                  type="text"
                  name="resName"
                  id="resName"
                  placeholder="Nhập Tên"
                  class="form__input"
                  path="fisrtName"
                />
                <img
                  src="client/assets/icons/message.svg"
                  alt=""
                  class="form__input-icon"
                />
              </div>
            </div>

            <c:set var="errorEmail">
              <form:errors
                path="email"
                cssClass="form__error"
                tag="p"
                style="display: block"
              />
            </c:set>
            <div class="form__group ${not empty errorEmail ? 'invalid' : ''}">
              <div class="form__text-input">
                <form:input
                  type="text"
                  name="resEmail"
                  id="email"
                  placeholder="Nhập Email"
                  class="form__input"
                  path="email"
                />

                <img
                  src="client/assets/icons/message.svg"
                  alt=""
                  class="form__input-icon"
                />
              </div>
              ${errorEmail}
            </div>

            <c:set var="errorPassword">
              <form:errors
                path="password"
                cssClass="form__error"
                tag="p"
                style="display: block"
              />
            </c:set>
            <div
              class="form__group ${not empty errorPassword ? 'invalid' : ''}"
            >
              <div class="form__text-input">
                <form:input
                  type="password"
                  name="new-password"
                  id="password"
                  placeholder="Mật khẩu"
                  class="form__input pass-input"
                  path="password"
                />
                <i
                  class="fas fa-eye togglePassword form__input-icon"
                  style="cursor: pointer; font-size: 2rem"
                ></i>
              </div>
              ${errorPassword}

              <span class="form__error d-block"
                ><ul>
                  <li style="margin-top: 2rem">
                    Mật khẩu phải có ít nhất 6 ký tự
                  </li>
                  <li style="margin-top: 2rem">
                    Một chữ cái hoa ,một chữ số,một ký tự đặc biệt
                  </li>
                </ul></span
              >
            </div>

            <c:set var="errorConfirmPassword">
              <form:errors
                path="confirmPassword"
                cssClass="form__error"
                tag="p"
                style="display: block"
              />
            </c:set>
            <div
              class="form__group ${not empty errorConfirmPassword ? 'invalid' : ''}"
            >
              <div class="form__text-input">
                <form:input
                  type="password"
                  name="confirmPassword"
                  id="confirmPassword"
                  placeholder="Xác nhận mật khẩu"
                  class="form__input pass-input"
                  path="confirmPassword"
                />
                <i
                  class="fas fa-eye togglePassword form__input-icon"
                  style="cursor: pointer; font-size: 2rem"
                ></i>
              </div>
              ${errorConfirmPassword}
            </div>

            <div class="form__group auth__btn-group">
              <button class="btn btn--primary auth__btn">Đăng Ký</button>
            </div>
          </form:form>

          <p class="auth__text">
            Bạn đã có tài khoản?
            <a href="/login" class="auth__link auth__text-link">Đăng Nhập</a>
          </p>
        </div>
      </div>
    </main>

    <script src="/client/assets/js/res.js"></script>
    <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
