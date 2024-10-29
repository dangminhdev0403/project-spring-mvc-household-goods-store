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
          <a href="/admin/order">Quản lí đơn hàng</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/order/update/${order.id}">Cập nhật đơn hàng</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="card-title">Chi tiết đơn hàng</div>
          </div>
          <form:form
            action="/admin/order/update/${order.id}"
            modelAttribute="order"
            class="row"
            enctype="multipart/form-data"
          >
           
            <div class="card-body" >
              <div class="row  mb-3" style="border-bottom: 1px solid #ebecec;">
                <div class="col-md-6 col-lg-6">
                  <div class="form-group">
                    <label for="reciver-name">Tên khách hàng</label>

                    <form:input
                      type="text"
                      class="form-control"
                      id="reciver-name"
                      placeholder="Nhập tên khách hàng"
                      path="receiverName"
                    />
                  </div>
                  <div class="form-group">
                    <label for="reciver-phone">SDT khách hàng</label>

                    <form:input
                      type="text"
                      class="form-control"
                      id="reciver-phone"
                      placeholder="Nhập SDT khách hàng"
                      path="receiverPhone"
                    />
                  </div>
                  
                </div>
                <div class="col-md-6 col-lg-6">

                  <div class="form-group">
                    <label for="oder">Địa chỉ</label>

                    <form:input
                      type="text"
                      class="form-control"
                      id="oder"
                      placeholder="Nhập đơn hàng"
                      path="receiverAddress"
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
                        items="${orderStatuses}"
                        varStatus="st"
                      >
                        <form:option value="${status}"> ${status.displayName} </form:option>
                      </c:forEach>
                    </form:select>
                  </div>
                  </div>
              </div>
              <div class="row">

                <h6 class="card-title mt-2 ms-3  " style="font-size: 1.3rem; font-weight: 500;">Danh sách đơn mua</h6>
                <div class="col-12">
                  <table class="table table-bordered table-head-bg-info table-bordered-bd-info mt-4">
                    <thead>
                      <tr>
                        <th scope="col">ID </th>
                        <th scope="col">First</th>
                        <th scope="col">Last</th>
                        <th scope="col">Handle</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>1</td>
                        <td>Mark</td>
                        <td>Otto</td>
                        <td>@mdo</td>
                      </tr>
                      <tr>
                        <td>2</td>
                        <td>Jacob</td>
                        <td>Thornton</td>
                        <td>@fat</td>
                      </tr>
                      <tr>
                        <td>3</td>
                        <td colspan="2">Larry the Bird</td>
                        <td>@twitter</td>
                      </tr>
                    </tbody>
                  </table>
</div>
              </div>
            </div>
           
            <div class="card-action">
              <button class="btn btn-success">Xác nhận</button>
              <a href="/admin/order" class="btn btn-danger">Trờ về</a>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
