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
          <a href="/admin/categories-parent">Quản lí danh mục cha</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/category-parent/update/${newCategory.id}">Cập nhật danh mục cha</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Cập nhật danh mục cha</div>
          </div>
          <form:form
            action="/admin/category-parent/update/${newCategory.id}"
            modelAttribute="newCategory"
            class="row"
            method = "POST"
          >
            <div class="card-body">
              <div class="row">
                <div class="col-md-6 col-lg-6">
                  <div class="form-group">
                    <label for="categories">Tên danh mục</label>
                   
                    <form:input
                      type="text"
                      class="form-control"
                      id="categories"
                      placeholder="Nhập danh mục"
                      path="name"
                    />
                  </div>
                 
                </div>
              </div>
            </div>
            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/categories-parent" class="btn btn-danger">Trờ về</a>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
