## 个人博客系统
在家养伤无聊开发的个人博客系统
基本功能已完善,剩余其他功能还在开发中......
[Demo展示](http://www.yinpengfei.com)
## 使用技术：
1. Maven + Git项目管理
2. SSM架构（Spring SpringMVC Mybatis）
3. Shiro 登录注册，权限认证，角色管理，盐值加密
4. FastDfs 图片服务器
5. Mysql数据库

## 配置
1. client.conf 配置Tracker_server为FastDfs IP
2. db.properties 数据库配置
3. image.properties 图片服务器访问地址前缀,如http://47.104.251.24/
4. 需要自己maven install fastdfs_client Jar包,参考如下:
    ```
    <groupId>fastdfs_client</groupId>
    <artifactId>fastdfs_client</artifactId>
    <version>1.25</version>
    ```

## 运行
1. 默认地址：http://127.0.0.1:8080/
2. maven运行 clean tomcat7:run