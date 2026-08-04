# 🐙 Lộ Trình Git Cho DevOps & Project Manager Chuyên Sâu Toàn Tập (Git for DevOps & PM Master Roadmap)

Bộ giáo trình được thiết kế chuyên biệt và đầy đủ nhất dành cho **Kỹ sư DevOps**, **Project Manager (PM / Scrum Master)**, **Tech Lead / Engineering Manager** và **Người mới bắt đầu** muốn thành thạo công nghệ quản lý phiên bản Git từ căn bản đến nâng cao để quản lý dự án phần mềm, tự động hóa CI/CD và GitOps.

---

## 🏛 Cấu Trúc Đạt Chuẩn 6 Phần Mỗi Bài Học

Mỗi bài học trong 15 Module Git tuân theo đúng 6 phần chuẩn mực:
1. **🧠 Hình Hình Dung Nhanh (Intuitive Mindset)**: Ẩn dụ thực tế giúp hình dung bản chất Git trong 1 phút cho người mới & PM.
2. **📚 Lý Thuyết Chuyên Sâu & Sơ Đồ Kiến Trúc (Under The Hood Architecture)**: Phân tích kiến trúc đồ thị DAG, `.git` internals, Git Engine, Merging/Rebasing & Sơ đồ Mermaid / Đồ họa trực quan.
3. **⚡ Bảng Tra Cứu Khái Niệm, Câu Lệnh & Tham Số (Reference Table)**: Bảng tham chiếu các câu lệnh Git CLI, tham số rebase, stash, reset, reflog kèm giải thích bản chất.
4. **🛠 Thao Tác Thực Chiến & Kịch Bản Quản Lý Dự Án (Production & PM Playbook)**: Cấu hình mẫu `.pre-commit-config.yaml`, `CODEOWNERS`, `.gitattributes`, ArgoCD GitOps YAML + Incident Response Playbook xử lý sự cố lọt lộ API key, bão merge conflict.
5. **🚀 Bộ Câu Hỏi Phỏng Vấn DevOps & Project Manager Thực Tế (Middle-Senior Interview Q&A)**: Bộ câu hỏi phỏng vấn tuyển dụng vị trí DevOps / Tech Lead / PM đào sâu bản chất quy trình và DORA Metrics.
6. **📝 Cheat Sheet Ghi Nhớ Nhanh (Summary)**: Bullet points tóm tắt ghi nhớ trong 30 giây.

---

## 📌 Danh Sách Lộ Trình 15 Bài Học Git Cho DevOps & Project Manager

### 📘 PHẦN 1: NỀN TẢNG GIT & CƠ CHẾ INTERNALS (BÀI 01 - 04)
- 📖 [**Bài 01: Kiến Trúc Bên Dưới Git Engine & Cấu Trúc Đối Tượng DAG**](./01.Git_Architecture_and_Internals/README.md) - Blob objects, Tree objects, Commit objects, Annotated Tags, Thư mục `.git`, Đồ thị DAG & Working Tree vs Index (Staging Area) vs Repository.
- 📖 [**Bài 02: Thành Thạo Lệnh Git CLI Căn Bản & Chuẩn Conventional Commits**](./02.Git_CLI_Fundamentals_and_Workflows/README.md) - `git init`, `clone`, `add`, `commit`, `status`, `diff`, `log`, `show`, `restore`, `rm`, `mv` & Quy chuẩn commit message Conventional Commits.
- 📖 [**Bài 03: Chuyên Sâu Quản Lý Nhánh (Branching), Merge & Rebase & Conflict Resolution**](./03.Git_Branching_and_Merging_Deep_Dive/README.md) - `git branch`, `checkout`, `switch`, `merge` (Fast-Forward vs 3-Way), `rebase` vs `merge`, `cherry-pick` & Giải quyết xung đột Merge Conflicts.
- 📖 [**Bài 04: Du Hành Thời Gian Với Git Stash, Reset, Revert & Reflog**](./04.Git_Stash_Reset_Revert_and_Time_Travel/README.md) - `git stash` (push, pop, apply, drop), `git reset` (soft, mixed, hard), `git revert` (Safe Undo trên Production) & `git reflog` cứu commit/nhánh bị xóa nhầm.

---

### 📙 PHẦN 2: BRANCHING STRATEGIES & RELEASE MANAGEMENT (BÀI 05 - 08)
- 📖 [**Bài 05: Các Mô Hình Quản Lý Nhánh (GitFlow, GitHub Flow, Trunk-Based)**](./05.Branching_Strategies_GitFlow_GitHubFlow_TrunkBased/README.md) - GitFlow (feature, develop, release, hotfix, main), GitHub Flow (feature -> PR -> main), Trunk-Based Development & Cách chọn mô hình dự án cho PM.
- 📖 [**Bài 06: Quản Lý Pull Request, Code Reviews & Branch Protection Rules**](./06.Pull_Requests_Code_Reviews_and_Branch_Protection/README.md) - GitHub/GitLab Branch Protection Rules (Require PR approval, Status checks, Signed commits), PR Review Templates & Cấu hình `CODEOWNERS`.
- 📖 [**Bài 07: Quản Lý Phiên Bản Phần Mềm Semantic Versioning & Release Tags**](./07.Semantic_Versioning_and_Release_Tags/README.md) - Semantic Versioning (MAJOR.MINOR.PATCH), Light-weight vs Annotated Tags (`git tag -a`), Tự động tạo Release Notes & Changelog.
- 📖 [**Bài 08: Kiến Trúc Mã Nguồn Monorepo vs Polyrepo & Git Submodules**](./08.Monorepo_vs_Polyrepo_Management/README.md) - Monorepo vs Polyrepo, Quản lý phụ thuộc với `git submodule` & `git subtree`, Các công cụ Monorepo (Nx, Turbo, Lerna) & Kịch bản quản lý dự án lớn của PM.

---

### 📕 PHẦN 3: DEVOPS AUTOMATION & GITOPS WORKFLOWS (BÀI 09 - 12)
- 📖 [**Bài 09: Tự Động Hóa Kiểm Tra Code Với Git Hooks & Pre-Commit Framework**](./09.Git_Hooks_and_Pre_Commit_Automation/README.md) - Git Client-side Hooks (pre-commit, commit-msg), Server-side Hooks (pre-receive), Framework `pre-commit` Python, tự động format code & quét secret lọt lộ.
- 📖 [**Bài 10: Triết Lý GitOps & Git Là Nguồn Sự Thật Duy Nhất (Single Source of Truth)**](./10.GitOps_Principles_and_Single_Source_of_Truth/README.md) - GitOps trong DevOps: Git là Nguồn sự thật duy nhất (Single Source of Truth), Declarative Infrastructure, Reconciliation Loop, ArgoCD / FluxCD.
- 📖 [**Bài 11: Quản Lý Tập Tin Dung Lượng Lớn Với Git LFS (Large File Storage)**](./11.Git_LFS_Large_File_Storage/README.md) - Git LFS (Large File Storage), Cấu hình `.gitattributes`, LFS Server, Tối ưu dung lượng đĩa cứng & Tránh làm chậm quá trình `git clone` trong CI/CD.
- 📖 [**Bài 12: Bảo Mật Git, Ký Commit GPG/SSH & Quét Rò Rỉ Secret**](./12.Git_Security_GPG_Signing_and_Secret_Scanning/README.md) - Ký commit với GPG Key / SSH Key (`git commit -S`), Verified Badge trên GitHub, Quét & gỡ bỏ triệt để Secret lọt lộ (`git-leaks`, BFG, `git filter-repo`).

---

### 📗 PHẦN 4: PM METRICS, TROUBLESHOOTING & CHEATSHEET (BÀI 13 - 15)
- 📖 [**Bài 13: Đo Lường Hiệu Suất Phát Triển DORA Metrics & Git Analytics Cho PM**](./13.Git_Analytics_and_DevOps_Metrics/README.md) - 4 DORA Metrics (Deployment Frequency, Lead Time for Changes, Change Failure Rate, Time to Restore), `git shortlog`, `git log --stat`, `git blame` & Velocity tracking cho PM.
- 📖 [**Bài 14: Sổ Tay Xử Lý Sự Cố Git Khẩn Cấp (Git Incident Playbooks)**](./14.Git_Troubleshooting_and_Incident_Playbooks/README.md) - Sửa nhầm commit đã lỡ push lên Production, Lỡ commit password/API key, Cứu nhánh bị xóa nhầm, Giải quyết bão Merge Conflicts & Sửa lỗi Corrupted `.git` Repo.
- 📖 [**Bài 15: Sổ Tay Tra Cứu Lệnh Git Thần Tốc (Git Master CheatSheet) & Best Practices**](./15.Git_Master_CheatSheet_and_Best_Practices/README.md) - Sổ tay tra cứu lệnh Git thần tốc (Cheat Sheet), 100+ lệnh CLI hay nhất, Cấu hình `.gitconfig` Alias & Các quy tắc NÊN và KHÔNG NÊN làm trong dự án.
