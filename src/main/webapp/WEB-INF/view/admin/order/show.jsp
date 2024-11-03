<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Quản lí đơn hàng</h3>
      <ul class="breadcrumbs mb-3">
        <li class="nav-home">
          <a href="/admin">
            <i class="icon-home"></i>
          </a>
        </li>

        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/order">Quản lí đơn hàng</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="d-flex align-items-center">
              <h4 class="card-title">Danh sách đơn hàng</h4>
            </div>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table
                id="add-row2"
                class="display table table-striped table-hover datatable-common"
              >
                <thead>
                  <tr>
                    <th>STT</th>
                    <th>Địa chỉ</th>
                    <th>SDT</th>
                    <th>Ngày đặt</th>
                    <th>Trạng thái</th>
                    <th style="width: 10%">Chi tiết</th>
                  </tr>
                </thead>

                <tbody>
                  <c:forEach
                    var="order"
                    items="${listOrders}"
                    varStatus="status"
                  >
                    <tr>
                      <td>${status.index + 1 }</td>
                      <td>${order.receiverName} , ${order.receiverAddress}</td>
                      <td>${order.receiverPhone}</td>
                      <td class="format-date">${order.orderDate}</td>
                      <td>${order.status.displayName}</td>
                      <td>
                        <div class="form-button-action">
                          <a
                            href="/admin/update/${order.id}"
                            data-bs-toggle="tooltip"
                            title=""
                            class="btn btn-link btn-primary btn-lg"
                            data-original-title="Edit Task"
                          >
                            <i class="fa fa-edit"></i>
                          </a>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../layout/footer.jsp" />
