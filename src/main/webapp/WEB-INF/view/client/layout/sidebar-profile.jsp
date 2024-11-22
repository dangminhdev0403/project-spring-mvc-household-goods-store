<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="col-3 col-xl-4 col-lg-5 col-md-12-1">
  <aside class="profile__sidebar">
    <!-- User -->
    <div class="profile-user">
      <c:if
        test="${not empty sessionScope.urlAvatar &&  sessionScope.urlAvatar != 'NULL'}"
      >
        <img
          src="${sessionScope.urlAvatar}"
          alt=""
          class="profile-user__avatar"
          style="width: 10rem; height: 10rem"
        />
      </c:if>
      <c:if
        test="${  empty sessionScope.urlAvatar &&  sessionScope.urlAvatar == NULL  }"
      >
        <img
          src="/client/assets/img/avatar/empty.jpg"
          alt=""
          class="profile-user__avatar"
          style="width: 10rem; height: 10rem"
        />
      </c:if>
      <h1 class="profile-user__name">${sessionScope.name}</h1>
    </div>

    <!-- Menu 1 -->
    <div class="profile-menu">
      <h3 class="profile-menu__title">Quản lí tài khoản</h3>
      <ul class="profile-menu__list">
        <li>
          <a href="/profile" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img src="/client/assets/icons/profile.svg" alt="" class="icon" />
            </span>
            Thông tin người dùng
          </a>
        </li>
        <li>
          <a href="/change-profile" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img
                src="/client/assets/icons/location.svg"
                alt=""
                class="icon"
              />
            </span>
            Quản lí địa chỉ
          </a>
        </li>
        <li>
          <a href="/manager-password" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img src="/client/assets/icons/lock.svg" alt="" class="icon" />
            </span>
            Mật khẩu
          </a>
        </li>
      </ul>
    </div>

    <!-- Menu 2 -->
    <div class="profile-menu">
      <h3 class="profile-menu__title">Sản phẩm của tôi</h3>
      <ul class="profile-menu__list">
        <li>
          <a href="/order-history" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img
                src="/client/assets/icons/download.svg"
                alt=""
                class="icon"
              />
            </span>
            Lịch sử mua hàng
          </a>
        </li>

        <li>
          <a href="affiliates" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img src="/client/assets/icons/gift-2.svg" alt="" class="icon" />
            </span>
            Đăng kí cộng tác viên
          </a>
        </li>
        <li>
          <a href="#!" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img src="/client/assets/icons/heart.svg" alt="" class="icon" />
            </span>
            Chờ cập nhật
          </a>
        </li>
      </ul>
    </div>

    <!-- Menu 4 -->
    <div class="profile-menu">
      <h3 class="profile-menu__title">Dịch vụ Khách hàng.</h3>
      <ul class="profile-menu__list">
        <li>
          <a href="#!" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img src="/client/assets/icons/info.svg" alt="" class="icon" />
            </span>
            Hỗ trợ
          </a>
        </li>
        <li>
          <a href="#!" class="profile-menu__link">
            <span class="profile-menu__icon">
              <img src="/client/assets/icons/danger.svg" alt="" class="icon" />
            </span>
            Diều khoản sử dụng
          </a>
        </li>
      </ul>
    </div>
  </aside>
</div>
