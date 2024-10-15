<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Quản lí đơn hàng</h3>
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
          <a href="#">Tables</a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="#">Datatables</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="d-flex align-items-center">
              <h4 class="card-title">Add Row</h4>
              <button
                class="btn btn-primary btn-round ms-auto"
                data-bs-toggle="modal"
                data-bs-target="#addRowModal"
              >
                <i class="fa fa-plus"></i>
                Add Row
              </button>
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
                    <th>Name</th>
                    <th>Position</th>
                    <th>Office</th>
                    <th style="width: 10%">Action</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>Name</th>
                    <th>Position</th>
                    <th>Office</th>
                    <th>Action</th>
                  </tr>
                </tfoot>
                <tbody>
                  <tr>
                    <td>Tiger Nixon</td>
                    <td>System Architect</td>
                    <td>Edinburgh</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Tiger Nixon</td>
                    <td>System Architect</td>
                    <td>Edinburgh</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Tiger Nixon</td>
                    <td>System Architect</td>
                    <td>Edinburgh</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Garrett Winters</td>
                    <td>Accountant</td>
                    <td>Tokyo</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Ashton Cox</td>
                    <td>Junior Technical Author</td>
                    <td>San Francisco</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Cedric Kelly</td>
                    <td>Senior Javascript Developer</td>
                    <td>Edinburgh</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Airi Satou</td>
                    <td>Accountant</td>
                    <td>Tokyo</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Brielle Williamson</td>
                    <td>Integration Specialist</td>
                    <td>New York</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Herrod Chandler</td>
                    <td>Sales Assistant</td>
                    <td>San Francisco</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Rhona Davidson</td>
                    <td>Integration Specialist</td>
                    <td>Tokyo</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Colleen Hurst</td>
                    <td>Javascript Developer</td>
                    <td>San Francisco</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>Sonya Frost</td>
                    <td>Software Engineer</td>
                    <td>Edinburgh</td>
                    <td>
                      <div class="form-button-action">
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-primary btn-lg"
                          data-original-title="Edit Task"
                        >
                          <i class="fa fa-edit"></i>
                        </button>
                        <button
                          type="button"
                          data-bs-toggle="tooltip"
                          title=""
                          class="btn btn-link btn-danger"
                          data-original-title="Remove"
                        >
                          <i class="fa fa-times"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
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
