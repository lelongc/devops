# 🌐 05.Distribution_Systems: Hệ Thống Phân Phối Cáp, Nguồn UPS & Điện Lạnh HVAC - Chuyên Sâu CompTIA Network+ Cho DevOps

> 💡 **Bản chất 1 câu**: Hệ thống tủ Rack, Patch Panel, Punchdown Block, kiểm tra cáp TDR/OTDR, nguồn điện UPS/PDU, hệ thống làm mát HVAC và chữa...  
> 🎯 **Trọng tâm thực chiến DevOps**: Nắm vững lý thuyết chuyên sâu, sơ đồ kiến trúc, bộ lệnh CLI chẩn đoán thực tế và bộ câu hỏi phỏng vấn tuyển dụng.

---

## 1. 🧠 Hình Hình Dung Nhanh (Intuitive Mindset)

Hệ thống tủ Rack, Patch Panel, Punchdown Block, kiểm tra cáp TDR/OTDR, nguồn điện UPS/PDU, hệ thống làm mát HVAC và chữa cháy Datacenter.

```mermaid
graph LR
    Server[Server Rack] --> PatchPanel[Patch Panel] --> Switch[Core Switch]
```

---

## 2. 📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)

### 2.1 Hệ Thống Phân Phối Cáp & Nguồn Datacenter (OBJ 2.4 & 5.5)
1. **Patch Panel & Cable Distribution**:
   - Patch Panel gom các đầu cáp âm tường từ khắp văn phòng về tủ Rack. Dùng dây dẻo Patch Cord nối ngắn từ Patch Panel sang Switch Port để tránh hỏng cáp chính.
2. **Thiết Bị Đo Kiểm Cáp TDR & OTDR**:
   - **TDR (Time-Domain Reflectometer)**: Bắn xung điện để đo khoảng cách vị trí cáp đồng bị đứt đè ngầm.
   - **OTDR (Optical TDR)**: Bắn xung ánh sáng đo suy hao dBm và tìm vị trí cáp quang bị gãy đứt ngầm.
3. **Hệ Thống Điện & Làm Mát**:
   - **UPS (Uninterruptible Power Supply)**: Bộ lưu điện dự phòng chuyển sang ắc quy instant khi mất điện lưới.
   - **PDU (Power Distribution Unit)**: Tủ phân phối nguồn thông minh trong Rack.
   - **HVAC**: Hệ thống điều hòa chính xác duy trì nhiệt độ 18-22°C và độ ẩm 40-50% cho Datacenter.
   - **Fire Suppression (FM-200 / Novec 1230)**: Hệ thống khí chữa cháy sạch dập lửa không dùng nước để bảo vệ linh kiện điện tử.


---

## 3. ⚡ Bảng Tra Cứu Câu Lệnh & Khái Niệm Thực Hành (Reference Table)

| Công cụ / Khái niệm | Loại / Protocol | Ý nghĩa chi tiết | Ứng dụng thực tế |
| :--- | :--- | :--- | :--- |
| **`Patch Panel`** | `Hardware` | Bảng cắm chuyển tiếp cáp âm tường tập trung trong Tủ Rack | `Quản lý gọn gàng dây cáp Datacenter` |
| **`TDR / OTDR`** | `Testing Tool` | Máy đo xác định chính xác khoảng cách mét vị trí đứt cáp | `Tìm điểm cáp ngầm bị đứt` |
| **`UPS / PDU`** | `Power System` | Bộ lưu điện dự phòng và thanh phân phối nguồn trong Rack | `Duy trì nguồn điện liên tục cho Server` |
| **`FM-200 / Novec`** | `Fire Suppression` | Hệ thống khí dập lửa sạch không dùng nước | `Chữa cháy an toàn cho Datacenter` |


---

## 4. 🛠 Thao Tác Thực Chiến & Kịch Bản DevOps

### 🛠 Các lệnh thực hành gõ là ăn ngay:
```bash
# Đọc thông số nhiệt độ cảm biến Server Linux:
sensors
```

### 🚀 Kịch bản xử lý sự cố thực tế khi đi làm:
Sự cố điều hòa HVAC Datacenter hỏng khiến nhiệt độ Server Rack vọt lên 40°C gây tự động shutdown khẩn cấp.

---

## 5. 🚀 Bộ Câu Hỏi Phỏng Vấn DevOps & Network Thực Tế (Interview Q&A)

> **Q: Máy đo OTDR (Optical Time-Domain Reflectometer) dùng để làm gì?**  
> **A**: Dùng để bắn tia sáng đo suy hao dBm và xác định vị trí mét chính xác bị đứt gãy trên tuyến cáp quang.

> **Q: Tại sao Datacenter không dùng hệ thống chữa cháy phun nước Sprinkler thông thường?**  
> **A**: Vì nước gây chập cháy hỏng hoàn toàn linh kiện điện tử. Datacenter bắt buộc dùng hệ thống khí sạch FM-200 hoặc Novec 1230 dập tắt lửa bằng cách rút oxy mà không gây hư hại thiết bị.



---

## 6. 📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)

- [x] Patch Panel: Nối chuyển tiếp cáp âm tường
- [x] OTDR: Đo điểm đứt cáp quang
- [x] HVAC: Điều hòa duy trì 18-22°C
- [x] FM-200: Khí dập lửa sạch cho Datacenter

