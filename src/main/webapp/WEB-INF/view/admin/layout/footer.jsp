
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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<!-- jQuery Scrollbar -->
<script src="/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
<!-- Datatables -->
<script src="/js/plugin/datatables/datatables.min.js"></script>
<!-- Kaiadmin JS -->
<script src="/js/kaiadmin.min.js"></script>
<!-- Kaiadmin DEMO methods, don't include it in your project! -->
<script src="/js/setting-demo2.js"></script>
<script src="/js/myscript.js"></script>

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
    "autoFill": { // Cấu hình cho tính năng AutoFill
        "columns": [0, 1], // Chỉ định các cột nào có thể sử dụng AutoFill
      
    },

    "initComplete": function () { // Hàm sẽ chạy khi DataTable đã khởi tạo xong
        // Bạn có thể thêm mã JavaScript tùy chỉnh ở đây nếu cần
    }
};


// Khởi tạo DataTable cho tất cả các bảng có class .datatable-common
$(document).ready(function() {
    $('.datatable-common').DataTable(dataTableCommonSettings);
});
</script>

<script>
        const fileInput = document.querySelector(".form-control.upload-img");
        const imagePreview = document.querySelector(".imagePreview");
        const removeImageBtn = document.querySelector(".removeImage");
        const imageInfo = document.querySelector(".imageInfo");


    // Hiển thị ảnh khi chọn file
    fileInput.addEventListener('change', function() {
            const file = this.files[0];
            
            if (file) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                    removeImageBtn.style.display = 'block'; // Hiện nút "X" khi có ảnh
                    imageInfo.style.display = 'block'; // Hiện nút "X" khi có ảnh
                }

                reader.readAsDataURL(file);
            }
        });

        // Gỡ bỏ ảnh xem trước và reset input
        removeImageBtn.addEventListener('click', function() {

            imagePreview.src = '';
            imagePreview.style.display = 'none';
            removeImageBtn.style.display = 'none';
            imageInfo.style.display = 'none'; // Hiện nút "X" khi có ảnh

            fileInput.value = ''; // Reset input file
        });

        function formatNumber(value) {
    return new Intl.NumberFormat('en-US', {
        maximumFractionDigits: 0, // Số chữ số thập phân tối đa
        minimumFractionDigits: 0 // Không có chữ số thập phân
    }).format(value);
}




</script>

<script>
let priceProductElement = document.querySelector(".form-control.priceProduct");
let priceProduct = priceProductElement.value.replace(/,/g, ''); // Lấy giá trị và xóa dấu phẩy

// Chuyển đổi chuỗi thành số
let numericPriceProduct = Number(priceProduct);

// Kiểm tra nếu là số hợp lệ
if (!isNaN(numericPriceProduct)) {
    let formattedPriceProduct = formatNumber(numericPriceProduct);
    priceProductElement.value = formattedPriceProduct;
    console.log(formattedPriceProduct);
} else {
    console.log("Giá trị không hợp lệ.");
}

function formatNumber(value) {
        return value.toString(); // Trả về chuỗi của giá trị
    }

   
    
    
 
</script>

<script>
  <c:if test="${not empty error}">
 
 swal( "Thất bại" ,  "${error}" ,  "error" )
 
     
 </c:if>
 </script>
  <script>
    
 function alertAppted(e) {
    e.preventDefault();   // Ngăn chặn hành động mặc định

    
    let deleteUrl = e.currentTarget.getAttribute('href');

    swal({
        title: "Bạn có chắc muốn xoá?",
        text: "Dữ liệu sẽ bị xoá vĩnh viễn",
        icon: "warning",  // Sử dụng "icon" thay vì "type"
        buttons: {
            cancel: {
                text: "Huỷ bỏ",      // Tùy chỉnh nút "Huỷ bỏ"
                visible: true,
                className: "btn btn-danger",
            },
            confirm: {
                text: "Đồng ý",
                className: "btn btn-success",
            },
        },
        reverseButtons: false,
    }).then((willDelete) => {
        if (willDelete) {
          window.location.href = deleteUrl;
        } else {
            // Người dùng nhấn cancel
          
        }
    });
}

// Chọn tất cả các phần tử có class is-delete
let isAlertElements = document.querySelectorAll(".is-delete");

// Lặp qua các phần tử và gắn sự kiện click cho từng phần tử
isAlertElements.forEach(function (element) {
    element.addEventListener('click', alertAppted);
});

  



<c:if test="${not empty success}">

swal( "Thành công" ,  "${success}" ,  "success" )

    
</c:if>

</script>

</body>

</html>