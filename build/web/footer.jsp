<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                margin-top: 0px;
            }

            footer {
                margin-left: 10px;
                margin: 5% -5% -5% -5%;
                background-color: #ffe082; /* Pastel yellow */
                color: #5d4037; /* Dark brown text */
                padding: 5px;
                border-radius: 10px; /* Rounded corners */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
                transition: background-color 0.3s; /* Smooth background transition */
            }

            footer:hover {
                background-color: #ffb300; /* Slightly darker yellow on hover */
            }

            h3 {
                color: #e65100; /* Darker orange */
                margin-bottom: 10px;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1); /* Text shadow for effect */
            }

            ul {
                list-style: none;
                padding: 0;
            }

            ul li {
                margin: 5px 0;
                transition: color 0.3s; /* Smooth text color transition */
            }

            ul li:hover {
                color: #f57c00; /* Darker orange on hover */
            }

            .contact-info p {
            }

            .footer-content {
                display: flex;
                justify-content: space-around;
            }

            .footer-info {
                flex: 1;
                text-align: center;
            }

            .footer-bottom {
                text-align: center;
                font-size: 13px;
            }
        </style>
    </head>
    <body>
        <footer>
            <div class="footer-content">
                <!-- Column 1 -->
                <div class="footer-info">
                    <h3>Dịch vụ BusSchool</h3>
                    <ul>
                        <li>Dành cho học sinh</li>
                        <li>Dành cho phụ huynh</li>
                        <li>Dành cho tài xế</li>
                    </ul>
                </div>
                <!-- Column 2 -->
                <div class="footer-info contact-info">
                    <h3>Liên hệ</h3>
                    <p>Khu Công nghệ cao Hòa Lạc, Km29 Đại lộ Thăng Long, huyện Thạch Thất, Hà Nội, Việt Nam</p>
                    <p>Hỗ trợ kỹ thuật: 1234-5678</p>
                </div>
                <!-- Column 3 -->
                <div class="footer-info">
                    <h3>Tiêu chí</h3>
                    <ul>
                        <li>An toàn</li>
                        <li>Đúng giờ</li>
                        <li>An tâm</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 - Bản quyền thuộc về Nhóm 2</p>
            </div>
        </footer>
    </body>
</html>
