<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Cập nhật</h3>
      <ul class="breadcrumbs mb-3">
        <li class="nav-home">
          <a href="#">
            <i class="icon-home"></i>
          </a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/users">Quản lí người dùng</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/users/update/">Cập nhật người dùng</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Cập nhật người dùng</div>
          </div>
          <form:form action="/admin/users/update" method ="post"
          modelAttribute="newUser" class="row form-user" enctype="multipart/form-data">
          <div class="card-body">
         
            <div class="row">
             

                <form:input
                type="id"
                class="form-control"
                
                  path="user_id"  style="display: none;"
              />
              <div class="col-md-6 col-lg-6">
                <div class="form-group">
                  <label for="email2">Email</label>
                  <form:input
                    type="email"
                    class="form-control"
                    id="email2"
                    placeholder="Enter Email"  path="email"
                  />
                </div>
                <div class="form-group">
                  <label for="password">Mật khẩu</label>
                  <form:input
                    type="password"
                    class="form-control"
                    id="password"
                    placeholder="Password"  path="password" disabled = "true"
                  />
                </div>
                <div class="form-group">
                  <label for="defaultSelect">Quyền</label>
                  <form:select class="form-select form-control" id="defaultSelect" path="role.name" >
                    <form:option value="CUSTOMER">Customer</form:option>
                    <form:option value="COLLABORATOR">Collaborator</form:option>

                  </form:select>
                </div>
              </div>
              <div class="col-md-6 col-lg-6">
                <div class="form-group">
                  <label for="fullname">Họ Tên</label>
                  <form:input
                    type="text"
                    class="form-control"
                    id="fullname"
                    placeholder="Nhập Họ và Tên" path="name"
                  />
                </div>
              
                <div class="form-group">
                  <label for="phone">Số điện thoại</label>
                  <form:input
                    type="phone"
                    class="form-control"
                    id="phone"
                    placeholder="Nhập số điện thoại"  path="phone"
                  />
                </div>
              </div>
              <div class="col-md-6 col-lg-4 ">
                <div class="form-group">

                  <label for="avatarImg">Avatar</label>
                  <input  class="form-control upload-img" type="file" id="avatarImg" 
                  accept=".png, .jpg, .jpeg" name="avatarImg" />

                <div class="form-control border-0 ">
               

                    <img class="imagePreviewold" src="${newUser.urlAvatar}" alt="Preview" style="max-width: 283px; display: block;">
  
                  </div>

                <div class="preview-container form-group">
                  <h6 class="imageInfo" style="display: none;">Avatar mới</h6>
                    <button type="button" class="close-btn border-0 bg-danger rounded-circle text-white removeImage" ><i class="fas fa-times"></i></button>
                    <img class="imagePreview" src="" alt="Preview" style="max-width: 283px; display: none;">
                </div>


                </div>
              </div>
              <div class="col-md-6 col-lg-4 " style="display: flex; gap: 30px;">
                <img src="${newUser.cccdFrontUrl}" style="width: 50%;" alt="">
                <img src="${newUser.cccdBackUrl}"  style="width: 50%;"alt="">
</div>
            </div>
          </div>
          <div class="card-action">
            <button class="btn btn-success">Xác nhận</button>
            <a class="btn btn-primary reset-mail" href ="/reset-password" email = ${newUser.email}>Đặt lại mật khẩu</a>
            <a href="/admin/users" class="btn btn-danger">Trờ về</a>
          </div>
          </form:form>
 
      
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
