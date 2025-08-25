# صورة أساس أقل ثغرات
FROM node:24.6.0-trixie-slim

# وضع الإنتاج
ENV NODE_ENV=production

# مجلد العمل داخل الحاوية
WORKDIR /app

# انسخ تعريفات الحزم أولاً للاستفادة من الكاش
COPY package*.json ./

# تثبيت تبعيات الإنتاج فقط (يتطلّب وجود package-lock.json)
RUN npm ci --omit=dev

# انسخ بقية السورس (تأكّد من إعداد .dockerignore)
COPY . .

# تشغيل بغير المستخدم root لزيادة الأمان
USER node

# الميناء الذي يستمع عليه التطبيق
EXPOSE 8080

# أمر التشغيل
CMD ["node", "index.js"]
