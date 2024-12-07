<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
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
          <a href="/admin/affiliate/widthdraw">Quản lí đơn rút tiền</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/withdrawal/update/{widthdraw.id}"
            >Cập nhật đơn rút tiền</a
          >
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Chi tiết đơn rút</div>
          </div>
          <form:form
            action="/admin/widthdraw/update/${widthdraw.id}"
            modelAttribute="widthdraw"
            class="row"
            enctype="multipart/form-data"
            method="post"
          >
            <input
              type="hidden"
              name="${_csrf.parameterName}"
              value="${_csrf.token}"
            />
            <div class="card-body">
              <div class="row mb-3" style="border-bottom: 1px solid #ebecec">
                <div class="col-md-6 col-lg-6">
                  <div class="form-group">
                    <label for="reciver-name">Tên Người rút</label>

                    <form:input
                      type="text"
                      class="form-control"
                      id="reciver-name"
                      placeholder="Nhập tên Người rút"
                      path="accountName"
                      readonly="true"
                    />
                  </div>
                  <div class="form-group">
                    <label for="reciver-phone">STK Người rút</label>

                    <form:input
                      type="text"
                      class="form-control"
                      id="reciver-phone"
                      placeholder="Nhập STK Người rút"
                      path="accountNumber"
                      readonly="true"
                    />
                  </div>
                </div>
                <div class="col-md-6 col-lg-6">
                  <div class="form-group">
                    <label for="oder">Ngân hàng</label>

                    <form:input
                      type="text"
                      class="form-control"
                      id="bankSelect"
                      placeholder="Nhập đơn hàng"
                      path="bankSelect"
                      readonly="true"
                    />
                  </div>
                  <div class="form-group">
                    <label for="oder">Số tiền rút</label>

                    <form:input
                      type="text"
                      class="form-control"
                      id="amount"
                      path="amount"
                      readonly="true"
                    />
                  </div>
                  <div class="form-group">
                    <label for="oder">Trạng thái</label>

                    <form:select
                      type="text"
                      class="form-control form-select"
                      id="oder"
                      placeholder="Nhập đơn hàng"
                      path="status"
                    >
                      <c:forEach
                        var="status"
                        items="${WithdrawStatus}"
                        varStatus="st"
                      >
                        <form:option value="${status}">
                          ${status.displayName}
                        </form:option>
                      </c:forEach>
                    </form:select>
                  </div>
                </div>
              </div>
             
            </div>

            <div class="card-action">
              <button class="btn btn-primary">Xác nhận</button>
              <a href="/admin/affiliate/widthdraw" class="btn btn-danger"
                >Trờ về</a
              >
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
