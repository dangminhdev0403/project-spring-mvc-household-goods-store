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
               
                <h2 class="cart-info__heading">Tham gia cộng tác viên</h2>
                <p class="cart-info__desc profile__desc">
                    "Gia nhập ngay đội ngũ cộng tác viên của chúng tôi để kiếm thêm thu nhập hấp dẫn, không cần vốn, linh hoạt thời gian và cơ hội nhận thưởng cao!                </p>
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
                   Đăng kí làm cộng tác viên ( chỉ cần gửi 2 mặt của căn cước)
                </h2>

                <form:form
                  action="/register-affilate"
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
                     Mặt trước căn cước công dân
                    </label>
                    <input  class="form-control upload-img" type="file" id="avatarImg" 
                    accept=".png, .jpg, .jpeg" name="cccdFrontUrl"  />


                  <c:if
                  test="${not empty currentUser.cccdFrontUrl &&  currentUser.cccdFrontUrl != 'NULL'}"
                >
                  
                <img   src="${currentUser.cccdFrontUrl}" style="max-width: 52%; border: 1px solid #ccc; margin-top: 2rem;"
                alt="Avatar" id="img-preview">

                </c:if>
                <c:if
              test="${ empty currentUser.cccdBackUrl }"
            >
              
            <img   src="aa" style="max-width: 52%; border: 1px solid #ccc; margin-top: 2rem;"
            alt="CCCD mặt trước" id="img-preview">

            </c:if>

                <label style="margin-top: 1rem;"
                      for="avatarImg  "
                      class="form__label form-card__label"
                    >
                     Mặt sau căn cước công dân
                    </label>
                <input  class="form-control upload-img" type="file" id="avatarImg2" 
                accept=".png, .jpg, .jpeg" name="cccdBackUrl"  />

                <c:if
                test="${not empty currentUser.cccdBackUrl &&  currentUser.cccdBackUrl != 'NULL'}"
              >
                
              <img   src="${currentUser.cccdBackUrl}" style="max-width: 52%; border: 1px solid #ccc; margin-top: 2rem;"
              alt="Avatar" id="img-preview2">

              </c:if>
              <c:if
              test="${ empty currentUser.cccdBackUrl }"
            >
              
            <img   src="aa" style="max-width: 52%; border: 1px solid #ccc; margin-top: 2rem;"
            alt="CCCD mặt sau" id="img-preview2">

            </c:if>


                    </div>


                  <div class="col-md-5">
                      
                      <div class="form__group">
  
                   
  
                        
                        <label
                          for="full-name"
                          class="form__label form-card__label"
                        >
                          Người dùng 
                        </label>
                        <div class="form__text-input">
                          <input
                            type="text"
                            name="fullName"
                            id="full-name"
                            placeholder="Nhập họ tên"
                            class="form__input"
                            autofocus=""
                            value ="${currentUser.name}"
                            style="cursor: not-allowed;"
                            readonly 
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
                          <p class="cart-info__desc profile__desc " style="font-size: 1.8rem; color: rgb(226, 57, 57);" >Email của bạn phải được xác thực trước.
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
                    <button class="btn btn--primary btn--rounded is-accept" type="submit">Gửi</button>
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
