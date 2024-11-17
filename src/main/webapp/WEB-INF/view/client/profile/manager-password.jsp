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
                    <div class="col-12">
                        <h2 class="cart-info__heading">

                          Mật khẩu
                        </h2>
                        <p class="cart-info__desc profile__desc" style="margin-bottom: 0; font-size: 1.5rem;">Đổi mật khẩu</p>
                        <div class="cart-info__separate"  style="margin-top: 1rem;"></div>

                        <form:form action="/change-pass"  class="form form-card"   modelAttribute="userPass" method ="POST"  >    
                            <!-- Form row 1 -->
                            <input
                            type="hidden"
                            name="${_csrf.parameterName}"
                            value="${_csrf.token}"
                          />
                                <div class="form__group">
                                    <label for="current-password" class="form__label form-card__label">
                                     Mật khẩu cũ
                                    </label>
                                    <div class="form__text-input">
                                        <input type="password" name="currentPassword" id="current-password" autocomplete="current-password" placeholder="Nhập mật khẩu cũ" class="form__input pass-input" required="" autofocus="">
                                        <i class="fas fa-eye togglePassword"  style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer; font-size: 2.5rem;"></i>

                                    </div>
                                    
                                </div>
                                <div class="form__group">
                                    <label for="new-password" class="form__label form-card__label">
                                        Mật khẩu mới
                                    </label>
                                    <div class="form__text-input">
                                        <form:input type="password" path="password" id="new-password" autocomplete="new-password" placeholder=" Nhập mật khẩu mới" class="form__input pass-input" />
                                        <i class="fas fa-eye togglePassword"  style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer; font-size: 2.5rem;"></i>
                                    </div>
                                </div>
                           

                                <c:set var="errorConfirmPassword">
                                    <form:errors
                                      path="confirmPassword"
                                      cssClass="form__error"
                                      tag="p"
                                      style="display: block; font-size: 1.8rem;"
                                    />
                                  </c:set>

                                <div class="form__group ${not empty errorConfirmPassword ? 'invalid' : ''}">
                                   



                                    <label for="confirm-password" class="form__label form-card__label">
                                        Xác nhận mật khẩu mới
                                    </label>
                                    <div class="form__text-input">
                                        <form:input type="password" path="confirmPassword" id="confirm-password" placeholder="Nhập lại mật khẩu mới" class="form__input pass-input" required=""/>
                                        <i class="fas fa-eye togglePassword"  style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer; font-size: 2.5rem;"></i>

                                    </div>
                                    ${errorConfirmPassword}
                                </div>
                                
                          

                            <div class="form-card__bottom">
                                <a class="btn btn--text"   href="/clientprofile.html">Cancel</a>
                                <button class="btn btn--primary btn--rounded is-accept">Save</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
          
           <!--  -->
        </div>

       
      </div>
    </div>
  </div>
</main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

