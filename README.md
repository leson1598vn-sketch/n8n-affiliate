# Deploy n8n lên Render (free, không cần thẻ) — từng bước

## Chuẩn bị (5 phút)
1. Tạo tài khoản tại **render.com** (đăng nhập bằng GitHub).
2. Tạo tài khoản tại **neon.tech** (đăng nhập bằng GitHub) → New Project → copy **connection string**
   (dạng `postgresql://user:pass@ep-xxx.neon.tech/n8n?sslmode=require`).

## Deploy (10 phút)
1. Đẩy thư mục `n8n-deploy/` này lên một repo GitHub mới (chỉ cần 3 file:
   `Dockerfile`, `render.yaml`, `README.md`).
2. Vào Render → **New** → **Blueprint** → chọn repo vừa đẩy → **Apply**.
3. Render dựng xong, mở service `n8n-affiliate` → **Settings** → xem URL thật
   (dạng `https://n8n-affiliate-xxxx.onrender.com`).
4. Vào **Environment**, sửa 2 biến cho khớp URL thật:
   - `N8N_HOST` → host thật (không có `https://`)
   - `WEBHOOK_URL` → `https://` + host thật + `/`
5. Điền 5 biến database từ connection string Neon:
   - `DB_POSTGRESDB_HOST`, `DB_POSTGRESDB_USER`, `DB_POSTGRESDB_PASSWORD`
     (port 5432 và database `n8n` đã có sẵn)
   - Hoặc đơn giản hơn: xóa 5 biến `DB_POSTGRESDB_*`, thêm 1 biến
     `DB_POSTGRESDB_CONNECTION_URL` = nguyên connection string Neon.
6. Bấm **Manual Deploy** → đợi ~3 phút → mở URL, tạo tài khoản admin n8n. Xong!

## Chống ngủ (5 phút)
Render free ngủ sau 15 phút không ai dùng → workflow hẹn giờ có thể trễ.
1. Đăng ký **cron-job.org** (free).
2. Tạo job mới: URL = `https://<host-của-bạn>/healthz`, mỗi **10 phút** 1 lần.
3. Xong — n8n của bạn coi như chạy 24/7.

## Kiểm tra nhanh
- Mở n8n → tạo workflow test 1 node Schedule → chạy thử.
- Vào terminal của service (Render → Shell): gõ `edge-tts --help` và
  `ffmpeg -version` — cả hai phải chạy được. Nếu không, báo tôi.

## Bước tiếp theo
Import file `../n8n-workflow-thoitrang.json` vào n8n (⋯ → Import from File),
rồi làm theo sticky note **SETUP** màu cam trong workflow.
