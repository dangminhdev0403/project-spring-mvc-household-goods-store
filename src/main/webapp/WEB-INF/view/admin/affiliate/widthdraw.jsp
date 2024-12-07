<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Danh sách đơn rút tiền</h3>
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
          <a href="/admin/affiliate/widthdraw">Danh sách đơn rút tiềnc</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="d-flex align-items-center">
              <h4 class="card-title">Danh sách đơn rút tiền</h4>
              
            </div>
          </div>
          <div class="card-body">
            <!-- Modal -->

            <div class="table-responsive">
              <table
                id="add-row1"
                class="display table table-striped table-hover datatable-common"
              >
                <thead>
                  <tr>
                    <th>Mã đơn</th>
                    <th>Ngày Tạo </th>
                    <th>Tên chủ tài khoản</th>
                    <th>Tên ngân hàng</th>
                    <th>Số tài khoản</th>
                    <th>Số Tiền</th>
                    <th>Trạng Thái</th>
                    <th>Thao tác</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach
                  var="withdraw"
                  items="${widthdraws}"
                 
                >

          <tr>
                  <td>${withdraw.id}</td>
                  <td class="format-date">${withdraw.createdAt}</td>
                  <td>${withdraw.accountName}</td>
                  <td>${withdraw.bankSelect}</td>
                  <td>${withdraw.accountNumber}</td>
                  <td class="format-price">${withdraw.amount}</td>
                  <td>
                    
                    ${withdraw.status.displayName}
                    </td>
                    <td>
                      <div class="form-button-action">
                        <a
                          href="/admin/withdrawal/update/${withdraw.id}"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </a>
                        </div>
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
