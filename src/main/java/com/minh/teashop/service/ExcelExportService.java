package com.minh.teashop.service;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletResponse;

@Service
public class ExcelExportService {

    public void exportDataToExcel(
            String customerName,
            String customerPhone,
            String address,

            String total,
            List<Map<String, Object>> orderList,
            HttpServletResponse response) throws IOException {

        // Tạo workbook và sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Order Data");

        // Thêm thông tin khách hàng vào các hàng đầu tiên
        int rowNum = 0;
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue("Tên khách hàng:");
        row.createCell(1).setCellValue(customerName);

        row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue("SĐT khách hàng:");
        row.createCell(1).setCellValue(customerPhone);

        row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue("Địa chỉ:");
        row.createCell(1).setCellValue(address);

        // Tạo tiêu đề cho danh sách đơn mua
        rowNum++;
        row = sheet.createRow(rowNum++);
        List<String> headers = List.of("Mã SP", "Số lượng", "Giá (bán ra) x1", "Tổng giá");
        for (int i = 0; i < headers.size(); i++) {
            row.createCell(i).setCellValue(headers.get(i));
        }

        // Thêm dữ liệu danh sách đơn mua
        for (Map<String, Object> order : orderList) {
            row = sheet.createRow(rowNum++);
            for (int i = 0; i < headers.size(); i++) {
                Object cellValue = order.get(headers.get(i));
                row.createCell(i).setCellValue(cellValue != null ? cellValue.toString() : "");
            }
        }

        // Thêm tổng cộng ở cuối
        row = sheet.createRow(rowNum++);
        row.createCell(2).setCellValue("Tổng:");
        row.createCell(3).setCellValue(total);

        // Thiết lập thông tin phản hồi để tải file Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=order_data.xlsx");

        // Xuất dữ liệu ra OutputStream
        OutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }

}
