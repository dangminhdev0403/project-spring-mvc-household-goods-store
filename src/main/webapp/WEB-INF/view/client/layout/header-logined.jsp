<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container">
  <div class="top-bar">
    <!-- More -->
    <button
      class="top-bar__more d-none d-lg-block js-toggle"
      toggle-target="#navbar"
    >
      <img
        src="/client/assets/icons/more.svg"
        alt=""
        class="icon top-bar__more-icon"
      />
    </button>

    <!-- Logo -->
    <a href="/" class="logo top-bar__logo">
      <img
        src="/client/assets/icons/logo.svg"
        alt="grocerymart"
        class="logo__img top-bar__logo-img"
      />
      <h1 class="logo__title top-bar__logo-title">grocerymart</h1>
    </a>

    <!-- Navbar -->
    <nav id="navbar" class="navbar hide">
      <button class="navbar__close-btn js-toggle" toggle-target="#navbar">
        <img class="icon" src="/client/assets/icons/arrow-left.svg" alt="" />
      </button>


      <div class="search nav-btn d-none d-md-flex">
        <form action="#"  style="justify-content: space-around;display: flex;width: 100%;border: 1px solid #ccc;border-radius: 2rem;height: 100%;">
          <input type="text" placeholder="tìm kiếm" name="search" >
            <button>
                <i class="fa fa-search"></i>
            </button>
        </form>
        

    </div>

      <a href="/cart" class="nav-btn d-none d-md-flex">
        <img
          src="/client/assets/icons/buy.svg"
          alt=""
          class="nav-btn__icon icon"
        />
        <span class="nav-btn__title">Giỏ hàng</span>
        <span class="nav-btn__qnt">${sessionScope.cartSum}</span>
      </a>

      <a href="#!" class="nav-btn d-none d-md-flex">
        <img
          src="/client/assets/icons/heart.svg"
          alt=""
          class="nav-btn__icon icon"
        />
        <span class="nav-btn__title">Favorite</span>
        <span class="nav-btn__qnt">3</span>
      </a>

      <ul class="navbar__list js-dropdown-list">
       
        <li class="navbar__item">
          <a href="#!" class="navbar__link">
           Danh mục
            <img
              src="/client/assets/icons/arrow-down.svg"
              alt=""
              class="icon navbar__arrow"
            />
          </a>
          <div class="dropdown js-dropdown">
            <div class="dropdown__inner">
              <div class="top-menu">
                <div class="sub-menu sub-menu--not-main">
                  
                  <c:forEach var="category" items="${categories}">
                    <div class="sub-menu__column">
                      <!-- Menu column 1 -->
                      <div class="menu-column">
                       
                        <div class="menu-column__content">
                          <h2 class="menu-column__heading" >
                            <a href="#!" style="font-size: 2.5rem;">${category.name}</a>
                          </h2>
                          <ul class="menu-column__list">
                            <c:forEach var="childCategory" items="${category.children}">
                              <li class="menu-column__item">
                                <a href="/category/${childCategory.category_id}" class="menu-column__link" style="font-size: 1.8rem;">${childCategory.name}</a>
                              </li>
                            </c:forEach>

                          </ul>
                        </div>
                      </div>
                    </div>

                  </c:forEach>



                </div>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </nav>
    <div class="navbar__overlay js-toggle" toggle-target="#navbar"></div>

    <!-- Actions -->
    <div class="top-act">
      <div class="top-act__group d-md-none top-act__group--single">
        <div class="search">
          <form action="#" style="border-radius: 2rem;">
              <input type="text" placeholder="tìm kiếm"
                     name="search" style="font-size: 2.5rem;" >
              <button  class="btn-search">
                  <i class="fa fa-search"></i>
              </button>
          </form>
      </div>
      </div>
          

      <c:if test="${not empty pageContext.request.userPrincipal}">
      

      
      <div id="drop-cart" class="top-act__group d-md-none " >
         
        


          <div  class="top-act__btn-wrap" >
            <a href="/cart" class="top-act__btn">
              <img
               src="/client/assets/icons/buy.svg"
                alt=""
                class="icon top-act__icon"
              />
              <span class="top-act__title">${sessionScope.cartSum}</span>
            </a>

            <!-- Dropdown -->
            <div class="act-dropdown" >
              <div class="act-dropdown__inner">
                <img
                 src="/client/assets/icons/arrow-up.png"
                  alt=""
                  class="act-dropdown__arrow"
                />
                <div class="act-dropdown__top" style="justify-content: center;">
                  <c:choose>
                    <c:when test="${sessionScope.cartSum == 0}" >
                      <h2 class="act-dropdown__title">Bạn chưa có sản phẩm trong giỏ hàng</h2>
                    </c:when>
    <c:when test="${sessionScope.cartSum <= 3}" >
      <h2 class="act-dropdown__title">Bạn có ${sessionScope.cartSum} sản phẩm trong giỏ hàng</h2>
    </c:when>
    <c:otherwise>
      <h2 class="act-dropdown__title">3/${sessionScope.cartSum} sản phẩm trong giỏ hàng</h2>
    </c:otherwise>
</c:choose>
       

                  
                </div>

                <div class="row row-cols-3 gx-2 act-dropdown__list " style="justify-content: center;"  id ="dropdown__list">
                  
                                    <c:forEach begin ="0" end ="2" var="detailOfCart" items="${listDetail}" >
                                      <div class="col">
                                        <article class="cart-preview-item">
                                          <div class="cart-preview-item__img-wrap">
                                            <img
                                             src="/upload/products/${detailOfCart.product.productImages[0].name}"
                                              alt="  ${detailOfCart.product.name}"
                                              class="cart-preview-item__thumb"
                                            />
                                          </div>
                                          <h3 class="cart-preview-item__title">
                                            ${detailOfCart.product.name}
                                          </h3>
                                          <p class="cart-preview-item__price">
                                            <c:choose>
                                              <c:when test="${detailOfCart.product.price != null}">
                                                <c:if test="${detailOfCart.product.price % 1 != 0}">
                                                  <fmt:formatNumber
                                                    value="${detailOfCart.product.price}"
                                                    pattern="#,##0.000"
                                                  />
                                                  đ
                                                </c:if>
                                                <c:if test="${detailOfCart.product.price % 1 == 0}">
                                                  <fmt:formatNumber
                                                    value="${detailOfCart.product.price}"
                                                    pattern="#,##0"
                                                  />
                                                  đ
                                                </c:if>
                                              </c:when>
                                            </c:choose>
                                            </p>
                                            
                                        </article>
                                      </div>
                  </c:forEach>
                    
                  

                
                </div>
                
                <div class="cart-info__separate" style="margin: 0; margin-bottom: 2rem;"></div>
                <div class="act-dropdown__checkout">
                  <a
                    href="/cart"
                    class="btn btn--primary btn--rounded act-dropdown__checkout-btn"
                  >
                    Xem giỏ hàng
                  </a>
                </div>
              </div>
            </div>
           
          </div>
        </div>

        <div class="top-act__user">





          <c:if
          test="${not empty sessionScope.urlAvatar &&  sessionScope.urlAvatar != 'NULL'}"
        >
        <img
        src="${sessionScope.urlAvatar}"
        alt=""
        class="top-act__avatar"
      />
        </c:if>
        <c:if
          test="${  empty sessionScope.urlAvatar &&  sessionScope.urlAvatar == NULL  }"
        >
          <img
            src="/client/assets/img/avatar/empty.jpg"
            alt=""
            class="profile-user__avatar"
          />
        </c:if>


          <!-- Dropdown -->
          <div class="act-dropdown top-act__dropdown">
            <div class="act-dropdown__inner user-menu">
              <img
                src="/client/assets/icons/arrow-up.png"
                alt=""
                class="act-dropdown__arrow top-act__dropdown-arrow"
              />

              <div class="user-menu__top">
                <c:if test="${not empty sessionScope.avatar}">
                  <img
                    src="/upload/avatar/${sessionScope.avatar}"
                    alt=""
                    class="user-menu__avatar"
                  />
                </c:if>
                <c:if test="${ empty sessionScope.avatar}">
                  <img
                    src="/client/assets/img/avatar/empty.jpg"
                    alt=""
                    class="user-menu__avatar"
                  />
                </c:if>

                <div>
                  <p class="user-menu__name">${sessionScope.name}</p>
                  <p>
                    <c:out value="${pageContext.request.userPrincipal.name}" />
                  </p>
                </div>
              </div>

              <ul class="user-menu__list">
                <li>
                  <a href="/profile" class="user-menu__link"
                    >Trang cá nhân</a
                  >
                </li>
                <li>
                  <a href="/order-history" class="user-menu__link"
                    > Lịch sử mua hàng</a
                  >
                </li>

                <li class="user-menu__separate">
                  <form method="post" action="/logout">
                    <input
                      type="hidden"
                      name="${_csrf.parameterName}"
                      value="${_csrf.token}"
                    />
                    <button class="user-menu__link" style="font-size: 1.9rem">
                      Đăng xuất
                    </button>
                  </form>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </c:if>
      <c:if test="${ empty pageContext.request.userPrincipal}">
        <a href="/login" class="btn btn--text d-md-none">Đăng nhập</a>
        <a href="/register" class="top-act__sign-up btn btn--primary"
          >Đăng kí</a
        >
      </c:if>
    </div>
  </div>
</div>
