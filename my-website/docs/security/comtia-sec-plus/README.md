# 🛡 Giáo Trình CompTIA Security+ (SY0-701 / SY0-601): An An Thông Tin Cho DevSecOps & Security Engineer

Bộ tài liệu được biên dịch và hệ thống hóa chuyên sâu 100% dựa trên toàn bộ lộ trình khóa học **CompTIA Security+ (SY0-701 / SY0-601)** chính thức trên Udemy (`rm.txt`), thiết kế dành cho **người mới bắt đầu**, **DevSecOps Engineer**, **Security Analyst** và **System Administrator**.

Giáo trình tập trung vào **bản chất an ninh thông tin (Under-the-Hood Mechanics)**, sơ đồ kiến trúc Mermaid, bảng lệnh CLI thực chiến, kịch bản ứng phó sự cố SecOps Incident Response Playbooks và bộ câu hỏi phỏng vấn tuyển dụng Senior.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 20 Module Security+ tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất công nghệ an ninh mạng trong 1 phút cho người mới.
2. **📚 Lý Thuyết Chuyên Sâu & Bản Chất Hệ Thống (Under The Hood Architecture)**: Phân tích sơ đồ Mermaid, Attack Vectors, Data Structures và nguyên lý hoạt động bên dưới.
3. **⚡ Bảng Tra Cứu Khái Niệm & Câu Lệnh Thực Hành (Reference Table)**: Bảng tham chiếu lệnh, công cụ, flags kèm giải thích chi tiết.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản SecOps**: Bộ lệnh gõ ăn ngay (`nmap`, `tshark`, `openssl`, `sha256sum`, `trivy`, `semgrep`, `rkhunter`) + Kịch bản xử lý sự cố thực tế khi đi làm.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevSecOps & Security Thực Tế (Interview Q&A)**: Bộ câu hỏi đào sâu bản chất an ninh kèm câu trả lời mẫu chuẩn tuyển dụng Senior.
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 20 Module CompTIA Security+

### 📘 PHẦN 1: MỐI ĐE DỌA, TẤN CÔNG & CON NGƯỜI (MODULE 01 - 06)
- 📖 [**Module 01: Security Fundamentals**](./01.Security_Fundamentals/README.md) - Tam giác CIA, Non-repudiation, Security Control Categories/Types & Zero Trust Architecture.
- 📖 [**Module 02: Threat Actors & Attack Surfaces**](./02.Threat_Actors_and_Attack_Surfaces/README.md) - Kẻ tấn công (Script Kiddies, Hacktivists, APT, Insider), Threat Vectors & Attack Surface Reduction.
- 📖 [**Module 03: Physical Security & Social Engineering**](./03.Physical_Security_and_Social_Engineering/README.md) - An ninh vật lý (Mantraps, Faraday Cages) & Tấn công Social Engineering (Phishing, Spear Phishing, Whaling, Pretexting, Watering Hole).
- 📖 [**Module 04: Malware Threats**](./04.Malware_Threats/README.md) - Phân loại Malware (Viruses, Worms, Trojans, Ransomware, Rootkits, Fileless Malware) & Cơ chế ẩn giấu Kernel.
- 📖 [**Module 05: Application & Software Security**](./05.Application_and_Software_Security/README.md) - Top lỗ hổng Web OWASP (SQLi, XSS, CSRF, Buffer Overflow, SSRF) & DevSecOps CI/CD Tools (SAST, DAST, SCA).
- 📖 [**Module 06: Network Attacks**](./06.Network_Attacks/README.md) - Tấn công tầng mạng (TCP SYN Flood DoS, ARP Spoofing, DNS Poisoning, Replay Attacks, Evil Twin Wi-Fi).

---

### 📙 PHẦN 2: MẬT MÃ HỌC, PKI & IAM (MODULE 07 - 11)
- 📖 [**Module 07: Cryptographic Fundamentals**](./07.Cryptographic_Fundamentals/README.md) - Mã hóa Đối xứng (AES-256) vs Bất đối xứng (RSA/ECC) vs Mã Băm (SHA-256) & Salt chống Rainbow Table.
- 📖 [**Module 08: Public Key Infrastructure & Certificates**](./08.Public_Key_Infrastructure_and_Certificates/README.md) - PKI (Root CA -> Intermediate CA), CSR Request, Chứng chỉ X.509, CRL vs OCSP vs OCSP Stapling.
- 📖 [**Module 09: Identity and Access Management (IAM)**](./09.Identity_and_Access_Management_IAM/README.md) - Mô hình AAA, Kerberos TGT (Port 88), SSO (SAML 2.0, OAuth 2.0, OpenID Connect), MFA (FIDO2) & Directory Services.
- 📖 [**Module 10: Network Security Architecture**](./10.Network_Security_Architecture/README.md) - Kiến trúc mạng an toàn (DMZ, Internal Zone), Firewalls (Stateless/Stateful/NGFW/WAF), IDS/IPS, 802.1X NAC & Honeypots.
- 📖 [**Module 11: Wireless and Mobile Security**](./11.Wireless_and_Mobile_Security/README.md) - Bảo mật Wi-Fi (WPA3-SAE, EAP-TLS, PEAP), MDM (Mobile Device Management) & Remote Wipe.

---

### 📕 PHẦN 3: GIAO THỨC, CLOUD, SECOPS & PENTESTING (MODULE 12 - 16)
- 📖 [**Module 12: Secure Network Design & Protocols**](./12.Secure_Network_Design_and_Protocols/README.md) - Thay thế giao thức plain-text (HTTP, Telnet, FTP) sang mã hóa (HTTPS, SSH, SFTP, IPsec ESP, SNMPv3).
- 📖 [**Module 13: Cloud Security & Virtualization**](./13.Cloud_Security_and_Virtualization/README.md) - Mô hình Shared Responsibility Model (IaaS/PaaS/SaaS), CASB & Container Security (Trivy, Non-root user).
- 📖 [**Module 14: Security Operations & Monitoring**](./14.Security_Operations_and_Monitoring/README.md) - Kiến trúc SecOps (SIEM, SOAR Playbooks, EDR/XDR, File Integrity Monitoring FIM).
- 📖 [**Module 15: Vulnerability Management & Pentesting**](./15.Vulnerability_Management_and_Pentesting/README.md) - Quét lỗ hổng (Nessus), Thang điểm CVSS, Quy trình Pentest (Black/White Box) & Red/Blue/Purple Team.
- 📖 [**Module 16: Incident Response & Forensics**](./16.Incident_Response_and_Forensics/README.md) - Quy trình 6 bước ứng phó sự cố NIST SP 800-61, Order of Volatility (RAM dump) & Chain of Custody.

---

### 📗 PHẦN 4: QUẢN LÝ RỦI RO, QUY TRÌNH & TUÂN THỦ (MODULE 17 - 20)
- 📖 [**Module 17: Risk Management and Assessment**](./17.Risk_Management_and_Assessment/README.md) - Đánh giá rủi ro định lượng (ALE = SLE x ARO), 4 chiến lược Rủi ro (Mitigation, Transference, Avoidance, Acceptance).
- 📖 [**Module 18: Disaster Recovery & Business Continuity**](./18.Disaster_Recovery_and_Business_Continuity/README.md) - BCP/DRP, RTO vs RPO, So sánh các bản Backup (Full, Incremental, Differential) & Hot/Cold Sites.
- 📖 [**Module 19: Governance, Compliance & Privacy**](./19.Governance_Compliance_and_Privacy/README.md) - Đạo luật & Tiêu chuẩn tuân thủ (GDPR, PCI-DSS, HIPAA, ISO 27001), PII/PHI, Anonymization vs Pseudonymization.
- 📖 [**Module 20: Security Awareness and Culture**](./20.Security_Awareness_and_Culture/README.md) - Đào tạo nhận thức an ninh, Phishing Simulation, Password Manager, Clean Desk Policy & Remote Work Security.
