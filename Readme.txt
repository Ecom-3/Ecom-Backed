cd D:\ecom\Ecom\ecom-backend
powershell -NoProfile -ExecutionPolicy Bypass -File .\run-all-services.ps1 start
It automatically loads your .env and starts all core backend services in dependency order.
To include the frontend:
.\run-all-services.ps1 start -StartFrontend
To also include legacy alerts and Kafka:
.\run-all-services.ps1 start -StartFrontend -EnableLegacyAlerts
You need Java 21, Maven, MySQL with the required schemas, and your .env configuration. The frontend also requires Node.js/npm. Missing passwords or synchronization keys will prompt you for input.
Once started:
- Frontend: http://127.0.0.1:5173
- API gateway: http://localhost:8082
- Eureka: http://localhost:8761
- Logs: D:\ecom\Ecom\.local\logs
Restart or stop backend services:
.\run-all-services.ps1 restart
.\run-all-services.ps1 stop
If you started the frontend, stop it separately:
.\run-all-services.ps1 stop frontend

Test-NetConnection localhost -Port 8082
Invoke-RestMethod http://localhost:8082/actuator/health


Role	Example username
Super admin	admin
Global admin	globaladmin
Location admin	locationadmin
Store manager	storemanager
Delivery partner	deliverypartner
Customer	demo.customer@example.com
Customer	priya.nair@example.com

password : admin123