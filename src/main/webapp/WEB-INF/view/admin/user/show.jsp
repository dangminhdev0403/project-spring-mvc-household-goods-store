<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Quản lí user</h3>
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
          <a href="/admin/user">Quản lí người dùng</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="d-flex align-items-center">
              <h4 class="card-title">Danh sách người dùng</h4>
              <a
                href="/admin/users/create"
                class="btn btn-primary btn-round ms-auto"
              >
                <i class="fa fa-plus"></i>
                Thêm mới người dùng
              </a>
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
                    <th>Tên</th>
                    <th>Email</th>
                    <th>Quyền</th>
                    <th>Trạng thái</th>
                    <th style="width: 10%">Thao tác</th>
                  </tr>
                </thead>

                <tbody>
                  <c:forEach var="user" items="${listUsers}">
                    <tr>
                      <td>${user.name}</td>
                      <td>${user.email}</td>
                      <td>${user.role.name}</td>
                      <td>
                        <c:if test="${user.enabled == true}">
                          Đã kích hoạt

                        </c:if>
                        
                        <c:if test="${user.enabled != true}">
                        Chưa kích hoạt

                        </c:if>




                      </td>

                      <td>
                        <div class="form-button-action">
                          <a
                            href="/admin/user/update/${user.user_id}"
                            data-bs-toggle="tooltip"
                            title=""
                            class="btn btn-link btn-primary btn-lg"
                            data-original-title="Edit Task"
                          >
                            <i class="fa fa-edit"></i>
                          </a>
                          <a
                            href="/admin/user/delete/${user.user_id}"
                            data-bs-toggle="tooltip"
                            title=""
                            class=" btn btn-link  btn-danger is-delete"
                            data-original-title="Remove"
                          >
                            <i class="fa fa-times is-delete"  href="/admin/user/delete/${user.user_id}" ></i>
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
