# Устанавливаем базовый образ Node.js
FROM node:18 AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем исходный код
COPY . .

# Сборка приложения
RUN npm run build

# Устанавливаем базовый образ для финальной сборки
FROM nginx:alpine

# Копируем собранное приложение в папку для статических файлов
COPY --from=build /app/build /usr/share/nginx/html

# Открываем порт 80
EXPOSE 80

# Команда для запуска Nginx
CMD ["nginx", "-g", "daemon off;"]
