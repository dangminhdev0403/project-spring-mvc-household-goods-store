<%@ page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quên mật khẩu | Grocery Mart</title>

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

    <!-- Fonts and Styles -->
    <link rel="stylesheet" href="client/assets/fonts/stylesheet.css" />
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
      <div class="auth__content">
        <div class="auth__content-inner">
          <a href="/" class="logo">
            <img
              src="client/assets/icons/logo.svg"
              alt="grocerymart"
              class="logo__img"
            />
            <h2 class="logo__title">grocerymart</h2>
          </a>
          <h1 class="auth__heading">Quên mật khẩu</h1>
          <p class="auth__desc">
            Nhập email của bạn để nhận liên kết khôi phục mật khẩu.
          </p>

          <form
            action="/reset-password"
            method="get"
            class="form auth__form rest-pass"
            id="reset"
            onsubmit="return false;"
          >
            <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />

            <div class="form__group">
              <div class="form__text-input">
                <input
                  type="email"
                  name="email"
                  id="email"
                  
                  placeholder="Nhập email của bạn"
                  class="form__input email email-reset"
                  required
                  autocomplete="email"
                />
                <img
                  src="client/assets/icons/message.svg"
                  alt=""
                  class="form__input-icon"
                />
              </div>
            </div>

            <div class="form__group auth__btn-group">
              <a
                class="btn btn--primary auth__btn submit-reset"
                style="cursor: pointer" id="reset-pass"
                >Gửi yêu cầu</a
              >
              <p id="wait-p" class="btn btn--primary auth__btn d-none"></p>
            </div>
          </form>

          <p class="auth__text">
            Nhớ mật khẩu?
            <a href="/login" class="auth__link auth__text-link">Đăng Nhập</a>
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
