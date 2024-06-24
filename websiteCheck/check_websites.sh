#!/bin/bash

# Масив з URL вебсайтів
websites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
)

# Назва файлу логів
logfile="website_status.log"

# Очистити файл логів перед початком нової перевірки
> "$logfile"

# Перевірка доступності кожного вебсайту
for website in "${websites[@]}"; do
  # Використання curl для перевірки статусу вебсайту
  status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -L "$website")
  
  # Запис результату у файл логів
  if [ "$status_code" -eq 200 ]; then
    echo "[$website]($website) is UP" | tee -a "$logfile"
  else
    echo "[$website]($website) is DOWN" | tee -a "$logfile"
  fi
done

echo "Перевірка завершена. Результати записані у файл $logfile."
