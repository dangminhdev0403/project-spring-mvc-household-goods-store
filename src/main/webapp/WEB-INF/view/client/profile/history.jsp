<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="checkout-page">
    <div class="container">
    
  
      <!-- Breadcrumbs -->
      <div class="checkout-container">
        <ul class="breadcrumbs checkout-page__breadcrumbs">
          <li>
            <a href="/" class="breadcrumbs__link">
              Trang chủ
              <img src="/client/assets/icons/arrow-right.svg" alt="" />
            </a>
          </li>
          <li>
            <a
              href="/order-history"
              class="breadcrumbs__link breadcrumbs__link--current"
              >Lịch sử mua hàng</a
            >
          </li>
        </ul>
      </div>
  
      <!-- Checkout content -->
      <div class="checkout-container">
        <div class="row gy-xl-3">
          <div class="col-12">
            <div class="cart-info">
              <h1 class="cart-info__heading">Lịch sử mua hàng</h1>
              <c:if test ="${empty listOrders}">
                <h1 class="display-2 alert alert-danger text-center" style="display: block; font-size: 2.8rem">
                 Bạn chưa có đơn hàng nào.
                </h1>
              </c:if>
              <c:if test ="${not empty listOrders}">
  
                <div class="cart-info__check-all" style="margin-bottom: 5rem;">
                  <div class="cart-info__continue">
                    <label class="cart-info__checkbox">
                      <input
                        type="checkbox"
                        name="shipping-adress"
                        class="cart-info__checkbox-input check-all-box"
                        
                      />
                    </label>
                    <a
                      href="/client/checkout.html"
                      style="margin-left: 7.2rem"
                      class="cart-info__checkout-all btn btn--primary btn--rounded is-cancel"
                    >
                      Huỷ đơn đã chọn
                    </a>
                  </div>
                </div>
                <div class="cart-info__list" style="margin-top: 3rem;">
                  <c:forEach var="order" items="${listOrders}">
  
                  <div  class="d-flex" style="justify-content: space-between;">
                    
                  </div>
                  <h1 class="cart-info__heading" style="padding-top: 2rem;"> 
                    <input
                      type="checkbox"
                      name="shipping-adress"
                      class="cart-info__checkbox-input checkbox"
                      
                    />
                 Đơn hàng vào <span class="format-date" style="margin-left: 1rem;"> ${order.orderDate}</span></h1>
  
                  <form action="/cancel-oder" method="post">
  
                    <input
                    type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}"
                  />
                  <input type="hidden" >
                    <button style="margin-left: auto;"
                    class="cart-item__checkout-btn btn btn--primary btn--rounded is-cancel"
                  >
                    Huỷ
                  </button>
                  </form>
  
                   
                    <c:forEach var="orderDetail" items="${order.orderDetail}">
                    <   <article class="cart-item" style="cursor: pointer;">
                     
                      <a href="/product/${orderDetail.product.product_id}">
                        <img
                                                 src="${orderDetail.product.productImages[0].url}"

                          alt=""
                          class="cart-item__thumb"
                        />
                      </a>
                      <div class="cart-item__content">
                        <div class="cart-item__content-left">
                          <h3 class="cart-item__title">
                            <a href="/product/${orderDetail.product.product_id}">
                              ${orderDetail.product.name}
                            </a>
                          </h3>
                         
                          <p class="cart-item__price-wrap ">
                          <span class="format-price">  ${orderDetail.product.price}</span> |
                            <span class="cart-item__status "
                              >${orderDetail.order.status.displayName}</span
                            >
                          </p>
                           <p class="cart-item__price-wrap ">
                            ${order.receiverName} (${order.receiverPhone}),
                            ${order.receiverAddress}
                          </p>
                          <div class="cart-item__ctrl-wrap">
                            <div class="cart-item__ctrl cart-item__ctrl--md-block">
                              <div class="cart-item__input">
                                ${orderDetail.product.category.name}
                              </div>
                              <div class="cart-item__input">
    
                                <span> Số lượng ${orderDetail.quantity}</span>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="cart-item__content-right">
    
                          <p class="cart-item__total-price format-price">
                            ${orderDetail.price} 
                          </p>
    
                         
                        </div>
                      </div>
                    </article>
                  </c:forEach>
                  </c:forEach>
                </div>
              </c:if>
             
  
              <div class="cart-info__bottom">
                <div class="cart-info__row cart-info__row-md--block" style="flex-direction: row; align-items: self-end;">
                  <div class="cart-info__continue">
                    <a href="/" class="cart-info__continue-link">
                      <img
                        class="cart-info__continue-icon icon"
                        src="/client/assets/icons/arrow-down-2.svg"
                        alt=""
                      />
                      Quay lại mua sắm
                    </a>
                  </div>
                  <div class="pagination d-flex justify-content-center mt-5" > 
                    <!-- Nút Previous chỉ hiện nếu không phải trang đầu tiên -->
                    <c:if test="${currentPage > 1}">
                      <li class="page-item">
                        <a class="page-link" href="/?page=${currentPage - 1}" aria-label="Previous">
                          <span aria-hidden="true">«</span>
                        </a>
                      </li>
                    </c:if>
                  
                    <!-- Danh sách các số trang -->
                    <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                      <li class="page-item">
                        <a
                          class="page-link ${(loop.index) eq currentPage ? 'active' : ''}"
                          href="/?page=${loop.index}"
                        >
                          ${loop.index}
                        </a>
                      </li>
                    </c:forEach>
                  
                    <!-- Nút Next chỉ hiện nếu không phải trang cuối cùng -->
                    <c:if test="${currentPage < totalPages}">
                      <li class="page-item">
                        <a class="page-link" href="/?page=${currentPage + 1}" aria-label="Next">
                          <span aria-hidden="true">»</span>
                        </a>
                      </li>
                    </c:if>
                  </div>
                  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
