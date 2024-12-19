<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="pay-success">
    <canvas id="confetti-canvas" class="confetti-canvas"></canvas>

  

    <div class="container pay-success ">
        <div class="success-card">
            <div class="success-icon">
                <svg class="checkmark" viewBox="0 0 24 24" fill="none" stroke="#4CAF50" stroke-width="3">
                    <path d="M20 6L9 17l-5-5"/>
                </svg>
            </div>

            <h1 style="font-size: 3.5rem; margin-bottom: 1rem;">Đặt Hàng Thành Công!</h1>
            <p style="font-size: 2.2rem; color:  #757575;">Cảm ơn bạn đã tin tưởng và đặt hàng!</p>

            <div class="order-summary">
                <div class="summary-item">
                    <h3 style="font-size: 2.2rem;">Mã Đơn Hàng</h3>
                    <p id="orderNumber" style="font-size: 1.8rem; font-weight: bold; margin-top: 0.5rem;"></p>
                </div>
                <div class="summary-item">
                    <h3 style="font-size: 2.2rem;">Thời Gian Đặt</h3>
                    <p id="orderTime" style="font-size: 1.8rem; margin-top: 0.5rem;"></p>
                </div>
                <div class="summary-item">
                    <h3 style="font-size: 2.2rem;">Trạng Thái</h3>
                    <p style="color: #f5a623; font-weight: bold; margin-top: 0.5rem; font-size: 1.8rem;">Chờ xác nhận</p>
                </div>
            </div>

           
            <div class="order-details" style="font-size: 2.2rem;">
                <h3 style="margin-bottom: 1rem; font-weight: bold;">Chi Tiết Đơn Hàng:</h3>
                <div id="orderDetails" style="display: grid; gap: 1rem;">
                    <!-- Order details will be inserted here -->
                </div>
            </div>

          

            <button class="button" onclick="location.href='/'">Tiếp Tục Mua Sắm</button>
        </div>
    </div>

    <script type="text/javascript">
        // JavaScript code
        const orderDetails = JSON.parse('${order}');
       
        console.log(orderDetails);

        
        const confetti = new ConfettiGenerator({
            target: 'confetti-canvas',
            max: 80,
            size: 1.5,
            animate: true,
            props: ['circle', 'square', 'triangle', 'line'],
            colors: [[165, 104, 246], [230, 61, 135], [0, 199, 228], [253, 214, 126]],
            clock: 25,
        });
        confetti.render();
        setTimeout(() => {
            confetti.clear();
        }, 3000);
    
        // Generate random order number
        const orderNum = "${customCode}";
        document.getElementById('orderNumber').textContent = orderNum;
    
        // Set current time
          const orderDate = "${orderDate}"; // Lấy giá trị từ JSP (dạng String)
            console.log(orderDate);
            
        // Chuyển chuỗi thành đối tượng Date của JavaScript
        const orderDateObj = new Date(orderDate);

        document.getElementById('orderTime').textContent = orderDateObj.toLocaleString('vi-VN');
    
     
    
        const orderDetailsHtml = orderDetails.map(item => `
            <div style="display: flex; justify-content: space-between; padding: 0.5rem 0; border-bottom: 1px solid #e0e0e0;">
                <div>
                    <h4 style="font-weight: 600;    font-size: 2.5rem;margin-bottom: 1.2rem;">\${item.productName}</h4> <!-- Escape EL -->
                    <p style="color: #757575;font-size: 1.8rem;">Số lượng: \${item.quantity}</p>
                </div>
                <div style="font-weight: bold;" class ="format-price">\${item.price}</div>
            </div>
        `).join('');
    
        document.getElementById('orderDetails').innerHTML = orderDetailsHtml;
    </script>
    

</main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
