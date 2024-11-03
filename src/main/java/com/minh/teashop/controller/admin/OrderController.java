package com.minh.teashop.controller.admin;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.service.ExcelExportService;
import com.minh.teashop.service.OrderService;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class OrderController {
    private final ProductService productService;
    private final ExcelExportService excelExportService;
    private final UserService userService;
    private final OrderService orderService;

    public OrderController(ProductService productService, UserService userService, OrderService orderService,
            ExcelExportService excelExportService) {
        this.productService = productService;
        this.excelExportService = excelExportService;
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrderAdminPage(Model model, HttpServletRequest request) {

        List<Order> listOrder = this.orderService.fetchOrder();

        model.addAttribute("listOrders", listOrder);
        return "admin/order/show";
    }

    @GetMapping("/admin/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Order order = this.orderService.getOrderById(id);
        List<OrderDetail> orderDetails = order == null ? new ArrayList<OrderDetail>() : order.getOrderDetail();

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("orderStatuses", OrderStatus.values());

        return "admin/order/update";
    }

    @PostMapping("/admin/order/update/{id}")
    public String handleUpdateOrder(@PathVariable long id, @ModelAttribute("order") Order updateOrder,
            RedirectAttributes redirectAttributes) {
        Order currentOrder = this.orderService.getOrderById(id);
        currentOrder.setReceiverName(updateOrder.getReceiverName());
        currentOrder.setReceiverAddress(updateOrder.getReceiverAddress());
        currentOrder.setReceiverPhone(updateOrder.getReceiverPhone());
        currentOrder.setStatus(updateOrder.getStatus());
        Order updatedOrder = this.orderService.handleSaveOrder(currentOrder);
        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");

        return "redirect:/admin/update/" + id;
    }

    @GetMapping("/export-excel/{id}")
    public void exportToExcel(HttpServletResponse response, @PathVariable long id) throws IOException {
        Order order = this.orderService.getOrderById(id);
        String customerName = order.getReceiverName();
        String customerPhone = order.getReceiverPhone();
        String address = order.getReceiverAddress();
        Double totalPriceValue = order.getTotalPrice();
        String totalPrice = NumberFormat.getInstance(Locale.getDefault()).format(totalPriceValue) + " đ";
        List<OrderDetail> orderDetails = order.getOrderDetail();
        List<Map<String, Object>> orderList = new ArrayList<>();

        for (OrderDetail detail : orderDetails) {
            

            Double price = detail.getPrice() ;
            String priceFormat = NumberFormat.getInstance(Locale.getDefault()).format(price) + " đ";
            Double total = detail.getPrice() * detail.getQuantity();
            String totalFormat = NumberFormat.getInstance(Locale.getDefault()).format(total) + " đ";
            Map<String, Object> productData = new HashMap<>();
            productData.put("Mã SP", detail.getProduct().getSku()); // Giả sử SKU là mã sản phẩm
            productData.put("Số lượng", detail.getQuantity());
            productData.put("Giá (bán ra) x1", priceFormat);
            productData.put("Tổng giá", (totalFormat));

            orderList.add(productData);
        }

        // Gọi service để xuất Excel
        excelExportService.exportDataToExcel(
                customerName,
                customerPhone,
                address,
                totalPrice,
                orderList,
                response);
    }

}
