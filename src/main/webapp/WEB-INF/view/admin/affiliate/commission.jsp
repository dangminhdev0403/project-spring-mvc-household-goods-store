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
          <a href="/admin">Dashboard</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/affiliate/commission">Thay đổi hoa hồng</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <form
            action="/admin/commission/update"
            class="row "
            enctype="multipart/form-data"
            method="post"
          >
            <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />
            <div class="card-header">
              <div class="card-title">Thay đổi hoa hồng</div>
            </div>
            <div class="card-body">
              <div class="col-md-6 col-lg-4">
                <div class="form-group">
                  <label for="commissionRate">Hệ số</label>
                  <input
                    class="form-control"
                    id="commissionRate"
                    name="commissionRate"
                    type="number"
                    step="0.01"
                    min="0"
                    value="${commission}"
                    placeholder="hệ số"
                  />
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
