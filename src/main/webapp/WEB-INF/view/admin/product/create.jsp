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
          <a href="/admin/products">Quản lí sản phẩm</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/products/create">Thêm mới sản phẩm</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <!-- adđ one -->
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Thêm mới sản phẩm</div>
          </div>
          <form:form
            action="/admin/product/create"
            modelAttribute="newProduct"
            class="row"
            enctype="multipart/form-data"
          >
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
                   
                    <label for="priceProduct">Giá gốc</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="priceProduct"
                      placeholder="Nhập giá sản phẩm"
                      path="fisrtPrice"
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

                    <form:option value="${category.category_id}">${category.name}</form:option>
                  </c:forEach>

                  </form:select>
                 

                 
                </div>
              </div>
              <div class="col-md-6 col-lg-4">
              
                   
                  <div class="form-group">
                   
                    <label for="descProduct">Mô tả</label>
                    <form:textarea
                      
                      class="form-control"
                      id="descProduct"
                      placeholder="Nhập mô tả"
                      path="description"
                    />

                   
                  </div>
                  <div class="form-group">
                   
                    <label for="descProduct">Hệ số</label>
                    <form:input
                      
                      class="form-control"
                      id="factor"
                      type="number"
                      step="0.01" min="0" 
                      placeholder="hệ số"
                      path="factor"
                    />

                   
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
            </div>
            </div>
            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/products" class="btn btn-danger">Trờ về</a>
            </div>
          </form:form>
        </div>
      </div>
      <!-- add many -->
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Thêm nhiều sản phẩm</div>
          </div>
          <form
            action="/admin/products/create" method="post"
            
            class="row"
            enctype="multipart/form-data"
          >
          <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />
            <div class="card-body">
              <div class="row">
                <div class="col-md-6 col-lg-4">
                
                  <div class="form-group">
                   
                    <label for="nameProduct">File excel sản phẩm</label>
                    <input
                    type="file"
                    class="form-control"
                    id="file-product"
                    name="fileProduct"
                    accept=".xlsx, .xls"
                />

                   
                  </div>
                 

                
              
              </div>
             
             
            
             
            </div>
            </div>
            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/products" class="btn btn-danger">Trờ về</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
