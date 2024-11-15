<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Thêm mới</h3>
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
          <a href="/admin/payment">Quản lí thanh toán</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/product/create">Thêm mới thanh toán</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Thêm mới thanh toán</div>
          </div>
          <form:form
            action="/admin/payment/create"
            modelAttribute="newPayment"
            class="row "
            enctype="multipart/form-data"
          >
            <div class="card-body">
              <div class="row">
                <div class="col-md-6 col-lg-4">
                 
                  <div class="form-group ">
                   
                    <label for="name2">Tên</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="name2"
                      placeholder="Tên phương thức thanh toán"
                      path="name"
                    />

                    ${errorname}
                  </div>
                
                  <div class="form-group">
                    <label for="description">Mô tả</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="description"
                      placeholder="Mô tả"
                      path="description"
                    />
                  
                  </div>
                
                </div>
                <div class="col-md-6 col-lg-4">
                 
                  <div class="form-group">
                    <label for="price">Giá</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="price"
                      placeholder="Nhập Giá"
                      path="price"
                    />
                   
                  </div>

                  <div class="form-group">
                    <label for="defaultSelect">Trạng thái</label>
                    <form:select
                      class="form-select form-control"
                      id="defaultSelect"
                      path="status"
                    >
                      <form:option value="true">Hiện</form:option>
                      <form:option value="false">ẩn</form:option>
                    </form:select>
                  </div>

                 
                
                
                </div>
                <div class="col-md-6 col-lg-4 ">
                  <div class="form-group">

                    <label for="avatarImg">Avatar</label>
                    <input  class="form-control upload-img" type="file" id="avatarImg" 
                    accept=".png, .jpg, .jpeg" name="avatarImg" />
                   

                  <div class="preview-container form-group">
                      <button type="button" class="close-btn border-0 bg-danger rounded-circle text-white removeImage" ><i class="fas fa-times"></i></button>
                      <img class="imagePreview" src="" alt="Preview" style="max-width: 283px; display: none;">
                  </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/payment" class="btn btn-danger">Trờ về</a>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
