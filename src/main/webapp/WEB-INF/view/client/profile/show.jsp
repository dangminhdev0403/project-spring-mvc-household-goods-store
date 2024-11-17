<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="profile">
  <div class="container">
    <!-- Search bar -->
   
   
    

    <!-- Profile content -->
    <div class="profile-container">
      <div class="row gy-md-3">
        <jsp:include page="../layout/sidebar-profile.jsp" />

        <div class="col-9 col-xl-8 col-lg-7 col-md-12-1">
          <div class="cart-info">
            <div class="row gy-3">
              <!-- Account info -->
              <div class="col-12">
               
                <h2 class="cart-info__heading">Thông tin tài khoản</h2>
                <p class="cart-info__desc profile__desc">
                 Thay đổi thông tin cá nhân
                </p>
                <div class="row gy-md-2 row-cols-2 row-cols-lg-1">
                  <!-- Account info 1 -->
                  <div class="col">
                    <a href="#" style="cursor: default;">
                      <article class="account-info">
                        <div class="account-info__icon">
                          <img
                            src="/client/assets/icons/message.svg"
                            alt=""
                            class="icon"
                          />
                        </div>
                        <div>
                          <h3 class="account-info__title">Email</h3>
                          <p class="account-info__desc">
                            ${sessionScope.email}
                          </p>
                        </div>
                      </article>
                    </a>
                  </div>

                  <!-- Account info 2 -->
                  <div class="col">
                    <a href="#" style="cursor: default;">
                      <article class="account-info">
                        <div class="account-info__icon">
                          <img
                            src="/client/assets/img/avatar/empty2.jpg"
                            alt=""
                            width="54px"
                            height="54px"
                            style="border-radius: 8px"
                          />
                        </div>
                        <div>
                          <h3 class="account-info__title">Họ tên</h3>
                          <p class="account-info__desc">${sessionScope.name}</p>
                        </div>
                      </article>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="cart-info">
            <div class="row gy-3">
              <div class="col-12">
                <h2 class="cart-info__heading">
                  <a   href="/clientprofile.html">
                    <img
                      src="/client/assets/icons/arrow-left.svg"
                      alt=""
                      class="icon cart-info__back-arrow"
                    />
                  </a>
                  Chỉnh sửa thông tin tài khoản
                </h2>

                <form:form
                  action="/update-profile"
                  class="form form-card"
                  method="post"
                  modelAttribute="currentUser"

                  enctype="multipart/form-data"

                >

                  <input
                    type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}"
                  />

                  
                  <!-- Form row 1 -->
                  <div class="form__row">

                    <div class="form__group col-md-6">
                      <label
                      for="avatarImg  "
                      class="form__label form-card__label"
                    >
                      Avatar
                    </label>
                    <input  class="form-control upload-img" type="file" id="avatarImg" 
                    accept=".png, .jpg, .jpeg" name="avatarImg"  />


                  <c:if
                  test="${not empty sessionScope.urlAvatar &&  sessionScope.urlAvatar != 'NULL'}"
                >
                  
                <img   src="${sessionScope.urlAvatar}" style="max-width: 52%; border-radius: 50% ; border: 1px solid #ccc; margin-top: 2rem;"
                alt="Avatar" id="img-preview">

                </c:if>
                <c:if
                  test="${  empty sessionScope.urlAvatar &&  sessionScope.urlAvatar == NULL  }"
                >
                  <img
                    src="/client/assets/img/avatar/empty.jpg" 
                    style="max-width: 45%; border-radius: 50% ; border: 1px solid #ccc; margin-top: 2rem;"
                    id="img-preview"
                    alt="Avatar"
                    
                  />
                </c:if>


                    </div>


                  <div class="col-md-5">
                      
                      <div class="form__group">
  
                   
  
                        
                        <label
                          for="full-name"
                          class="form__label form-card__label"
                        >
                          Họ Tên
                        </label>
                        <div class="form__text-input">
                          <form:input
                            type="text"
                            name="fullName"
                            id="full-name"
                            placeholder="Nhập họ tên"
                            class="form__input"
                            autofocus=""
                            path ="name"
                          />
                       

                          
                        </div>
                      </div>
                      <div class="form__group">
                        <label
                          for="email-adress"
                          class="form__label form-card__label"
                        >
                          Email
                        </label>
                        <div class="form__text-input">
                          <form:input
                            type="text"
                            name="email"
                            id="email-adress"
                            placeholder=" Nhập Email "
                            class="form__input"
                            path="email"
                          />
                         
                         
                        </div>
                       
                        <c:if test="${enabled == false}">
                          <p class="cart-info__desc profile__desc" style="font-size: 1.8rem;" >Email của bạn chưa được xác thực.
                            <div action="/verify-again" >
                              <input
                              type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"
                                 />
                              <a class="text-error submit-verify" style="color: rgb(69, 165, 239); text-decoration: underline;font-size: 1.8rem;cursor: pointer; ">Xác thực ngay </a>
                             
                            </div>
  
                            </p>
                        </c:if>
                       

                      

                       
                     
                      </div>

                  </div>
                  </div>

                 
                  <div class="form-card__bottom">
                    <a class="btn btn--text btn-reset" href="">Đặt lại</a>
                    <button class="btn btn--primary btn--rounded is-accept" type="submit">Lưu</button>
                  </div>
                </form:form>


                
                <p id = "countdownText"></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
