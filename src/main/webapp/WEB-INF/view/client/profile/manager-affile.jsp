<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="ctv-pro" style="margin-top: 2rem">
  <div class="container">
    <div class="cards">
      <div class="card">
        <h3>Doanh Thu</h3>
        <div class="stats format-price">${collaborator.totalEarnings}</div>
        <p>trong 12 tháng</p>
      </div>
      <div class="card">
        <h3>Hoa Hồng</h3>
        <div class="stats format-price">${collaborator.balance}</div>
        <p>Khả dụng</p>
      </div>
      <div class="card">
        <h3>Số dư có thể rút</h3>
        <div class="stats format-price">${collaborator.availableBalance}</div>
        <p>Tháng này</p>
      </div>
    </div>

    <div class="chart-container">
      <canvas id="revenueChart"></canvas>
    </div>

    <div class="actions">
      <button class="btn" onclick="openWithdrawModal()">Rút Tiền</button>
      <button class="btn" onclick="ctv_handleReferral()">Khách hàng</button>
      <button class="btn" onclick="ctv_handleAnalytics()">Đơn hàng</button>
    </div>

    <div class="table-container">
      <h1 style="font-size: 2rem; font-weight: bold; margin-bottom: 1rem">
        Lịch sử rút tiền
      </h1>
      <table class="table" id="table_withdrawal">
        <thead>
          <tr>
            <th>Mã đơn</th>
            <th>Ngày</th>
            <th>Tên chủ tài khoản</th>
            <th>Tên ngân hàng</th>
            <th>Số tài khoản</th>
            <th>Số Tiền</th>
            <th>Trạng Thái</th>
          </tr>
        </thead>
        <c:if test="${empty collaborator.withdrawals}">
          <tr>
            <td style="text-align: center; font-size: 1.9rem; font-weight: 500;"><h1>Chưa có đơn rút tiền</h1></td>
          </tr>
        </c:if>
        <c:if test="${ not empty collaborator.withdrawals}">
          
          <tbody>
            <c:forEach var="withdraw" items="${collaborator.withdrawals}">
              <tr>
                <td>${withdraw.id}</td>
                <td class="format-date">${withdraw.createdAt}</td>
                <td>${withdraw.accountName}</td>
                <td>${withdraw.bankSelect}</td>
                <td>${withdraw.accountNumber}</td>
                <td class="format-price">${withdraw.amount}</td>
                <td>
                  <span
                    class="ctv_dash_v2_status_${withdraw.status}"
                    style="
                      border-radius: 3rem;
                      padding: 0.4rem 0.8rem;
                      line-height: 3rem;
                    "
                    >${withdraw.status.displayName}</span
                  >
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </c:if>
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

<!-- rút tiền -->
<div class="ctv-withdraw-2024" style="font-size: 2rem">
  <div class="w24-modal" id="withdrawModal2024">
    <div class="w24-modal-content">
      <button class="w24-modal-close" onclick="closeWithdrawModal()">×</button>
      <h2 style="margin-bottom: 1.5rem; text-align: center">Rút Tiền</h2>

      <form
        class="w24-form"
        id="withdrawForm"
        onsubmit="handleWithdraw(event)"
        action=""
      >
        <div class="w24-input-group input-container">
          <label class="w24-label">Số Tiền Muốn Rút</label>
          <div class="input-wrapper">
            <input
              type="text"
              class="w24-input"
              id="withdrawAmount"
              placeholder="Tối thiểu 50,000đ"
              max="${collaborator.availableBalance}"
              required
              oninput="formatAmount(this)"
              onkeydown="handleKeydown(event)"
            />
          </div>
          <div
            id="errorMessage"
            class="error-message"
            style="color: red; padding-top: 1.2rem"
          ></div>
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
          <input
            type="text"
            class="w24-input"
            id="accountNumber"
            placeholder="Nhập số tài khoản"
            required
            pattern="[0-9]+"
            minlength="9"
            maxlength="14"
          />
        </div>

        <div class="w24-input-group">
          <label class="w24-label">Tên Chủ Tài Khoản</label>
          <input
            type="text"
            class="w24-input"
            id="accountName"
            placeholder="Nhập tên chủ tài khoản"
            required
            style="text-transform: uppercase"
          />
        </div>

        <button type="submit" class="w24-submit-btn" id="submitBtn">
          Xác Nhận Rút Tiền
        </button>
      </form>

      <div class="w24-loading" id="withdrawLoading"></div>
    </div>
  </div>
</div>

<!-- modal list customer -->
<!-- Modals -->
<div id="ctv_dash_v2_referralModal" class="ctv_dash_v2_modal">
  <!-- Modal content will be dynamically inserted -->
</div>

<div id="ctv_dash_v2_analyticsModal" class="ctv_dash_v2_modal">
  <!-- Modal content will be dynamically inserted -->
</div>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
