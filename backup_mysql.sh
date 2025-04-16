#!/bin/bash

# MySQL 数据库连接信息
CONTAINER_NAME="scf-mysql"  # Docker 容器名称
DB_USER="your_username"     # MySQL 用户名
DB_PASS="your_password"     # MySQL 密码
DB_NAME="your_database"     # 数据库名称
BACKUP_DIR="/workspaces/backup"  # 备份存储目录
DATE=$(date +%Y%m%d_%H%M%S)  # 当前时间戳

# 创建备份目录（如果不存在）
mkdir -p $BACKUP_DIR

# 备份数据库结构
docker exec $CONTAINER_NAME mysqldump -u $DB_USER -p$DB_PASS --no-data $DB_NAME > $BACKUP_DIR/${DB_NAME}_structure_$DATE.sql

# 备份数据库数据
docker exec $CONTAINER_NAME mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/${DB_NAME}_data_$DATE.sql

# 可选：压缩备份文件
gzip $BACKUP_DIR/${DB_NAME}_structure_$DATE.sql
gzip $BACKUP_DIR/${DB_NAME}_data_$DATE.sql

# 可选：删除7天前的备份
find $BACKUP_DIR -name "*.sql.gz" -mtime +7 -delete

echo "Backup completed: $BACKUP_DIR/${DB_NAME}_structure_$DATE.sql.gz and ${DB_NAME}_data_$DATE.sql.gz"