**应用部署小程序，练习用**

1. 运行sql(order/src/main/sql/order.sql)语句，配置数据库;
2. 根据自己数据库服务器的实际参数在环境变量中配置相应参数;
   ```bash
   export mysql_host=your db host
   export mysql_port=your db port
   export mysql_user=your db username
   export mysql_pwd=your db password
   ```
3. 完成配置之后能可以运行spring程序;
   ```bash
   mvn clean install
   mvn tomcat7:run
   ```