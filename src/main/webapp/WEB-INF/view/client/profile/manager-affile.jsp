<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="ctv-pro" style="margin-top: 2rem;">
  <div class="container">
   
    <div class="cards" >
      <div class="card">
        <h3>Doanh Thu</h3>
        <div class="stats">₫15.75M</div>
        <p>↑ 12% tháng trước</p>
      </div>
      <div class="card">
        <h3>Hoa Hồng</h3>
        <div class="stats">₫3.25M</div>
        <p>Khả dụng</p>
      </div>
      <div class="card">
        <h3>Đơn Hàng</h3>
        <div class="stats">127</div>
        <p>Tháng này</p>
      </div>
    </div>

    <div class="chart-container">
      <canvas id="revenueChart"></canvas>
    </div>

    <div class="actions">
      <button class="btn" onclick="openWithdrawModal()">Rút Tiền</button>
      <button class="btn" onclick="handleAction('referral')">Giới Thiệu</button>
      <button class="btn" onclick="handleAction('report')">Báo Cáo</button>
    </div>

    <div class="table-container">
      <table class="table">
        <thead>
          <tr>
            <th>Ngày</th>
            <th>Ngày</th>
            <th>Loại</th>
            <th>Số Tiền</th>
            <th>Trạng Thái</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>15/11</td>
            <td>15/11</td>
            <td>Rút tiền</td>
            <td>₫2.5M</td>
            <td><span class="status">Hoàn thành</span></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <script>
    const ctx = document.getElementById("revenueChart").getContext("2d");
    new Chart(ctx, {
      type: "line",
      data: {
        labels: ["T1", "T2", "T3", "T4", "T5", "T6"],
        datasets: [
          {
            label: "Doanh Thu",
            data: [12, 19, 3, 5, 2, 3],
            borderColor: "#3b82f6",
            tension: 0.4,
            fill: true,
            backgroundColor: "rgba(59, 130, 246, 0.1)",
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
      },
    });

    function handleAction(type) {
      anime({
        targets: ".card",
        scale: [1, 1.02, 1],
        duration: 300,
      });
    }

    // Initial animation
    anime({
      targets: ".card",
      translateY: [10, 0],
      opacity: [0, 1],
      delay: anime.stagger(100),
      duration: 500,
    });
  </script>
</main>



<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
<div class="ctv-withdraw-2024" style="font-size: 2rem;">

  <div class="w24-modal" id="withdrawModal2024">
      <div class="w24-modal-content">
          <button class="w24-modal-close" onclick="closeWithdrawModal()">×</button>
          <h2 style="margin-bottom: 1.5rem; text-align: center;">Rút Tiền</h2>
          
          <form class="w24-form" id="withdrawForm" onsubmit="handleWithdraw(event)">
              <div class="w24-input-group">
                  <label class="w24-label">Số Tiền Muốn Rút</label>
                  <input type="number" 
                         class="w24-input" 
                         id="withdrawAmount" 
                         min="100000" 
                         max="50000000" 
                         placeholder="Tối thiểu 100,000đ"
                         required
                         oninput="formatAmount(this)">
                  <div class="w24-error" id="amountError"></div>
              </div>

              <div class="w24-input-group">
                  <label class="w24-label">Chọn Ngân Hàng</label>
                  <select class="w24-select" id="bankSelect" required>
                      <option value="">Chọn ngân hàng</option>
                      <option value="vcb">Vietcombank</option>
                      <option value="tcb">Techcombank</option>
                      <option value="acb">ACB</option>
                      <option value="mb">MB Bank</option>
                      <option value="tpb">TPBank</option>
                  </select>
              </div>

              <div class="w24-input-group">
                  <label class="w24-label">Số Tài Khoản</label>
                  <input type="text" 
                         class="w24-input" 
                         id="accountNumber" 
                         placeholder="Nhập số tài khoản"
                         required
                         pattern="[0-9]+"
                         minlength="9"
                         maxlength="14">
              </div>

              <div class="w24-input-group">
                  <label class="w24-label">Tên Chủ Tài Khoản</label>
                  <input type="text" 
                         class="w24-input" 
                         id="accountName" 
                         placeholder="Nhập tên chủ tài khoản"
                         required
                         style="text-transform: uppercase;">
              </div>

              <button type="submit" class="w24-submit-btn" id="submitBtn">
                  Xác Nhận Rút Tiền
              </button>
          </form>

          <div class="w24-loading" id="withdrawLoading"></div>
      </div>
  </div>
</div>

<script>
  function openWithdrawModal() {
      const modal = document.getElementById('withdrawModal2024');
      modal.style.display = 'flex';
      anime({
          targets: '.ctv-withdraw-2024 .w24-modal-content',
          translateY: [20, 0],
          opacity: [0, 1],
          duration: 500,
          easing: 'easeOutCubic'
      });
  }

  function closeWithdrawModal() {
      anime({
          targets: '.ctv-withdraw-2024 .w24-modal-content',
          translateY: [0, 20],
          opacity: [1, 0],
          duration: 300,
          easing: 'easeInCubic',
          complete: function() {
              document.getElementById('withdrawModal2024').style.display = 'none';
              document.getElementById('withdrawForm').reset();
          }
      });
  }

  function formatAmount(input) {
      let value = input.value.replace(/\D/g, '');
      if (value > 50000000) value = 50000000;
      if (value < 0) value = 0;
      input.value = value;
      
      const formatted = new Intl.NumberFormat('vi-VN', {
          style: 'currency',
          currency: 'VND'
      }).format(value);
      
      document.getElementById('amountError').textContent = 
          value < 100000 ? 'Số tiền tối thiểu là 100,000đ' : '';
  }

  
  function handleWithdraw(event) {
      event.preventDefault();
      const submitBtn = document.getElementById('submitBtn');
      const loading = document.getElementById('withdrawLoading');
      
      submitBtn.disabled = true;
      loading.style.display = 'flex';

      // Simulate API call
      setTimeout(() => {
          loading.style.display = 'none';
          showSuccess();
      }, 2000);
  }

  function showSuccess() {
      const modalContent = document.querySelector('.ctv-withdraw-2024 .w24-modal-content');
      modalContent.innerHTML = `
          <div style="text-align: center;">
              <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                  <polyline points="22 4 12 14.01 9 11.01"></polyline>
              </svg>
              <h2 style="margin: 1rem 0;">Thành Công!</h2>
              <p style="margin-bottom: 2rem;">
                  Yêu cầu rút tiền đã được gửi.<br>
                  Chúng tôi sẽ xử lý trong vòng 24h.
              </p>
              <button class="w24-submit-btn" onclick="closeWithdrawModal()">Đóng</button>
          </div>
      `;
  }

  // Close modal when clicking outside
  document.getElementById('withdrawModal2024').addEventListener('click', function(e) {
      if (e.target === this) {
          closeWithdrawModal();
      }
  });
</script>