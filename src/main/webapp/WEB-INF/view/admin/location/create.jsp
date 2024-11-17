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
          <a href="/admin/payment">Quản lí vị trí</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/product/create">Thêm mới vị trí</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Thêm mới vị trí</div>
          </div>
          <form
            action="/admin/location/create"
            class="row"
            method="post"
            enctype="multipart/form-data"
          >
            <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />
            <div class="col-md-6 col-lg-4">
              <div class="form-group">
                <label for="fileExcel">File excel vị trí</label>
                <input
                  class="form-control upload-img"
                  type="file"
                  id="fileExcel"
                  accept=".xlsx, .xls"
                  name="fileExcel"
                />

                <div class="preview-container form-group">
                  <button
                    type="button"
                    class="close-btn border-0 bg-danger rounded-circle text-white removeImage"
                  >
                    <i class="fas fa-times"></i>
                  </button>
                  <img
                    class="imagePreview"
                    src=""
                    alt="Preview"
                    style="max-width: 283px; display: none"
                  />
                </div>
              </div>
            </div>

            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/payment" class="btn btn-danger">Trờ về</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
