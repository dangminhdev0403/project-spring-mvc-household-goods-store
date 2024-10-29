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
            <div class="card-body">
              <div class="row mb-3" style="border-bottom: 1px solid #ebecec">
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
                        <form:option value="${status}">
                          ${status.displayName}
                        </form:option>
                      </c:forEach>
                    </form:select>
                  </div>
                </div>
              </div>
              <div class="row">
                <h6
                  class="card-title mt-2 ms-3"
                  style="font-size: 1.3rem; font-weight: 500"
                >
                  Danh sách đơn mua
                </h6>
                <div class="col-12">
                  <table
                    class="table table-bordered table-head-bg-info table-bordered-bd-info mt-4"
                  >
                    <thead>
                      <tr>
                        <th
                          scope="col"
                          style="font-size: 1.2rem; text-align: center"
                        >
                          Mã SP
                        </th>
                        <th
                          scope="col"
                          style="font-size: 1.2rem; text-align: center"
                        >
                          Số lượng
                        </th>
                        <th
                          scope="col"
                          style="font-size: 1.2rem; text-align: center"
                        >
                          Giá(bán ra) x1
                        </th>
                        <th
                          scope="col"
                          style="font-size: 1.2rem; text-align: center"
                        >
                          Tổng giá
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach
                        var="detail"
                        items="${orderDetails}"
                        varStatus="st"
                      >
                        <tr>
                          <td style="font-size: 1.6rem; text-align: center">
                            ${detail.product.sku}
                          </td>
                          <td style="font-size: 1.6rem; text-align: center">
                            ${detail.quantity}
                          </td>
                          <td
                            style="font-size: 1.6rem; text-align: center"
                            class="format-price"
                          >
                            ${detail.price}
                          </td>
                          <td
                            style="font-size: 1.6rem; text-align: center"
                            class="format-price"
                          >
                            ${detail.price * detail.quantity }
                          </td>
                        </tr>
                      </c:forEach>

                      <tr>
                        <td colspan="4" class="text-center">
                          <span class="fw-bold" style="font-size: 2.2rem"
                            >Tổng: </span
                          >
                          <span
                            class="fw-bold format-price"
                            style="font-size: 2.2rem"
                           
                            >${order.totalPrice}</span
                          >
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>

            <div class="card-action">
              <button class="btn btn-primary">Xác nhận</button>
              <a href="/admin/order" class="btn btn-danger">Trờ về</a>
              <a href="/export-excel/${order.id}" class="btn btn-success">Xuất excel</a>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />
