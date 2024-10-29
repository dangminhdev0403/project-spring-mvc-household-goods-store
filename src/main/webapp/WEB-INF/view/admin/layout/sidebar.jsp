<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar" data-background-color="dark">
  <div class="sidebar-logo">
    <!-- Logo Header -->
    <div class="logo-header" data-background-color="dark">
      <a href="/admin" class="logo">
        <h1 class="text-light">Admin</h1>
      </a>
      <div class="nav-toggle">
        <button class="btn btn-toggle toggle-sidebar">
          <i class="gg-menu-right"></i>
        </button>
        <button class="btn btn-toggle sidenav-toggler">
          <i class="gg-menu-left"></i>
        </button>
      </div>
      <button class="topbar-toggler more">
        <i class="gg-more-vertical-alt"></i>
      </button>
    </div>
    <!-- End Logo Header -->
  </div>
  <div class="sidebar-wrapper scrollbar scrollbar-inner">
    <div class="sidebar-content">
      <ul class="nav nav-secondary">
        <li class="nav-item active">
          <a
            data-bs-toggle="collapse"
            href="#dashboard"
            class="collapsed"
            aria-expanded="false"
          >
            <i class="fas fa-home"></i>
            <p>Dashboard</p>
          </a>
        </li>
        <li class="nav-section">
          <span class="sidebar-mini-icon">
            <i class="fa fa-ellipsis-h"></i>
          </span>
          <h4 class="text-section">Components</h4>
        </li>
        <li class="nav-item">
          <a data-bs-toggle="collapse" href="#base">
            <i class="fas fas fa-users"></i>
            <p>Quản lí người dùng</p>
            <span class="caret"></span>
          </a>
          <div class="collapse" id="base">
            <ul class="nav nav-collapse">
              <li>
                <a href="/admin/users">
                  <span class="sub-item">Danh sách người dùng</span>
                </a>
              </li>
              <li>
                <a href="/admin/users/create">
                  <span class="sub-item">Thêm người dùng</span>
                </a>
              </li>
            </ul>
          </div>
        </li>
        <li class="nav-item">
          <a data-bs-toggle="collapse" href="#categories">
            <i class="fas fa-list"></i>
            <p>Quản lí danh mục</p>
            <span class="caret"></span>
          </a>
          <div class="collapse" id="categories">
            <ul class="nav nav-collapse">
              <li>
                <a href="/admin/categories-parent">
                  <span class="sub-item">Danh mục cha </span>
                </a>
              </li>
              
              <li>
                <a href="/admin/categories">
                  <span class="sub-item">Danh mục con </span>
                </a>
              </li>
             
            </ul>
          </div>
        </li>
        <li class="nav-item">
          <a data-bs-toggle="collapse" href="#product">
            <i class="fas fa-box"></i>
            <p>Quản lí Sản phẩm</p>
            <span class="caret"></span>
          </a>
          <div class="collapse" id="product">
            <ul class="nav nav-collapse">
              <li>
                <a href="/admin/products">
                  <span class="sub-item">Danh sách Sản Phẩm</span>
                </a>
              </li>
              <li>
                <a href="/admin/product/create">
                  <span class="sub-item">Thêm mới Sản Phẩm</span>
                </a>
              </li>
            </ul>
          </div>
        </li>

        <li class="nav-item">
          <a data-bs-toggle="collapse" href="#order">
            <i class="fas fa-clipboard-list"></i>
            <p>Quản lí đơn hàng</p>
            <span class="caret"></span>
          </a>
          <div class="collapse" id="order">
            <ul class="nav nav-collapse">
              <li>
                <a href="/admin/order">
                  <span class="sub-item">Danh sách đơn hàng</span>
                </a>
              </li>
            </ul>
          </div>
        </li>
      </ul>
    </div>
  </div>
</div>
