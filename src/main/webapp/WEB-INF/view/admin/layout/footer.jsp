
<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="footer">
  <div class="container-fluid d-flex justify-content-between">
    <nav class="pull-left">
      <ul class="nav">
        <li class="nav-item">
          <a class="nav-link" href="http://www.themekita.com">
            ThemeKita
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#"> Help </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#"> Licenses </a>
        </li>
      </ul>
    </nav>
    <div class="copyright">
      2024, made with <i class="fa fa-heart heart text-danger"></i> by
      <a href="http://www.themekita.com">ThemeKita</a>
    </div>
    <div>
      Distributed by
      <a target="_blank" href="https://themewagon.com/">ThemeWagon</a>.
    </div>
  </div>
</footer>
</div>


</div>
<!--   Core JS Files   -->
<script src="/js/core/jquery-3.7.1.min.js"></script>
<script src="/js/core/popper.min.js"></script>
<script src="/js/core/bootstrap.min.js"></script>

<!-- jQuery Scrollbar -->
<script src="/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
<!-- Datatables -->
<script src="/js/plugin/datatables/datatables.min.js"></script>
<!-- Kaiadmin JS -->
<script src="/js/kaiadmin.min.js"></script>
<!-- Kaiadmin DEMO methods, don't include it in your project! -->
<script src="/js/setting-demo2.js"></script>

<script>
  // Định nghĩa cấu hình chung
  var dataTableCommonSettings = {
    "language": {
        "sProcessing":   "Đang xử lý...",
        "sLengthMenu":   "Hiển thị _MENU_ dữ liệu",
        "sZeroRecords":  "Không tìm thấy dòng nào phù hợp",
        "sInfo":         "Đang hiển thị _START_ đến _END_ trong tổng số _TOTAL_ dữ liệu",
        "sInfoEmpty":    "Đang hiển thị 0 đến 0 của 0 dữ liệu",
        "sInfoFiltered": "(được lọc từ _MAX_ dữ liệu)",
        "sSearch":       "Tìm kiếm:",
        "oPaginate": {
            "sFirst":    "Đầu",
            "sPrevious": "Trước",
            "sNext":     "Tiếp",
            "sLast":     "Cuối"
        }
    },
    "lengthMenu": [10, 25, 50, 100], // Số lượng bản ghi trên mỗi trang
    "pageLength": 10, // Giá trị mặc định cho số lượng bản ghi hiển thị
    "pagingType": "simple_numbers", // Kiểu phân trang (có thể là "full", "simple", v.v.)
    "ordering": true, // Cho phép sắp xếp cột
    "order": [[0, "asc"]], // Thứ tự mặc định cho cột (cột 0 tăng dần)
    "searching": true, // Cho phép tìm kiếm
    "info": true, // Hiển thị thông tin số lượng bản ghi
    "responsive": true, // Tự động điều chỉnh kích thước bảng
    "autoWidth": false, // Tắt tự động điều chỉnh độ rộng cột
    "columnDefs": [ // Định nghĩa các cột cụ thể
        {
            "targets": [0], // Chỉ định cột (ví dụ cột đầu tiên)
            "className": "dt-center" // Căn giữa nội dung cột
        },
        {
            "targets": [1], // Ví dụ cho cột thứ hai
            "visible": true // hiện cột
        }
    ],
    "initComplete": function () { // Hàm sẽ chạy khi DataTable đã khởi tạo xong
        // Bạn có thể thêm mã JavaScript tùy chỉnh ở đây nếu cần
    }
};


// Khởi tạo DataTable cho tất cả các bảng có class .datatable-common
$(document).ready(function() {
    $('.datatable-common').DataTable(dataTableCommonSettings);
});
</script>
</body>
</html>