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
          <a href="/admin/users">Quản lí sản phẩm</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/users/create">Thêm mới sản phẩm</a>
        </li>
      </ul>
    </div>
    <div class="row">
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
                   
                    <label for="priceProduct">Giá</label>
                    <form:input
                      type="text"
                      class="form-control"
                      id="priceProduct"
                      placeholder="Nhập giá sản phẩm"
                      path="price"
                    />

                   
                  </div>

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
