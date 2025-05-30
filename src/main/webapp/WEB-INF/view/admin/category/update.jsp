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
          <a href="/admin/categories">Quản lí danh mục</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/categories/update">Cập nhật danh mục</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Cập nhật danh mục</div>
          </div>
          <form:form
            action="/admin/categories/update"
            modelAttribute="newCategory"
            class="row"
            enctype="multipart/form-data"
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
                      path="category_id"
                      style="display: none"
                    />
                    <form:input
                      type="text"
                      class="form-control"
                      id="categories"
                      placeholder="Nhập danh mục"
                      path="name"
                    />
                  </div>
                  <div class="col-md-6 col-lg-6">
                    <label for="email2">Danh mục cha</label>

                    <form:select class="form-control form-select" path="parent">
                  <form:option value="${newCategory.parent.id}">${newCategory.parent.name}</form:option>

                      <c:forEach var="parent" items="${listParenC}"  >
                        <c:if test="${parent.id != newCategory.parent.id}" >
                          <form:option value ="${parent.id}" >
                            ${parent.name}
                        </form:option>
                      </c:if>
                     
                  
                    </c:forEach>
                    <form:option value="">Không</form:option>

                  </form:select>
                </div>
                </div>
              </div>
            </div>
            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/categories" class="btn btn-danger">Trờ về</a>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
