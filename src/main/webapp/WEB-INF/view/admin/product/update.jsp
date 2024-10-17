<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
          <a href="/admin/products">Quản lí sản phẩm</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/product/update/">Cập nhật sản phẩm</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Cập nhật sản phẩm</div>
          </div>
          <form:form
            action="/admin/product/update"
            modelAttribute="newProduct"
            class="row"
            enctype="multipart/form-data"
          >
            <form:input
              type="id"
              class="form-control"
              path="product_id"
              style="display: none"
            />
            <div class="card-body">
              <div class="row">
                <div class="col-md-6 col-lg-4">
                  <div class="form-group">
                    <label for="nameProduct">Tên sản phẩm</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="nameProduct"
                      placeholder="Nhập tên sản phẩm"
                      path="name"
                    />
                  </div>
                  <div class="form-group">
                    <label for="priceProduct">Giá</label>
                    <form:input
                      type="text"
                      class="form-control priceProduct"
                      id="priceProduct"
                      placeholder="Nhập giá sản phẩm"
                      path="price"
                      />
                  </div>
                </div>
                <div class="col-md-6 col-lg-4">
                  <div class="form-group">
                    <label for="stock">Số lượng</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="stock"
                      placeholder="Nhập Số lượng"
                      path="stock"
                    />
                  </div>
                  <div class="form-group">
                    <label for="category">Danh mục</label>
                    <form:select
                      type="text"
                      class="form-control form-select"
                      id="category"
                      placeholder="Danh mục"
                      path="category.category_id"
                    >
                      <c:forEach var="category" items="${listCategories}">
                        <form:option value="${category.category_id}"
                          >${category.name}</form:option
                        >
                      </c:forEach>
                    </form:select>
                  </div>
                </div>
                <div class="col-md-6 col-lg-4">
                 
                  <div class="form-group">
                    <div class="form-group">
                      <label for="descProduct">Mô tả</label>
                      <form:textarea
                        class="form-control"
                        id="descProduct"
                        placeholder="Nhập mô tả"
                        path="description"
                      />
                    </div>
                  </div>
                </div>
                <div class="col-12 col-lg-4 ">
                  <div class="form-group">
  
                    <label for="avatarImg">Ảnh sản phẩm</label>
                    <input  class="form-control upload-img" type="file" id="productsImg" 
                    accept=".png, .jpg, .jpeg" name="productsImg" multiple/>
  
                   
                    
                  <div class="preview-container form-group">
                      <button type="button" class="close-btn border-0 bg-danger rounded-circle text-white removeImage" ><i class="fas fa-times"></i></button>
                      <img class="imagePreview" src="" alt="Preview" style="max-width: 283px; display: none;">
                  </div>
                  </div>
                  
                </div>
                <div class="row gap-2">
                   <c:if test="${not empty newProduct.productImages}">
                      
                        <c:forEach var="image" items="${newProduct.productImages}">
                          <img src="/upload/products/${image.name}" alt="" width="100%" height="200" class="col-12 col-lg-4 ">
                   </c:forEach>
                    
                    </c:if>
                </div>
              </div>
            </div>
            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/products" class="btn btn-danger">Trờ về</a>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
