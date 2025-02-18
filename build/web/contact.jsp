<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Contact</title>
        <link rel="icon" href="image/logo.png" type="image/x-icon" />
        <link rel="stylesheet" href="//bizweb.dktcdn.net/100/332/764/themes/894770/assets/bootstrap-4-3-min.css" />
        <script src="//bizweb.dktcdn.net/100/332/764/themes/894770/assets/jquery.min.js"></script>
        <style>
            .map iframe{
                width: 100%;
                height: 300px;
            }
            body {
                background-size: cover; /* Cover the entire viewport */
                background-position: center; /* Center the image */
                color: #4a4a4a; /* Dark gray text */
                font-family: "Nunito", sans-serif;
            }
        </style>
    </head>

    <body>

        <%@include file="header1.jsp" %>
        <br><br>
        <form style="margin-top: 100px; " action="contact" method="post">
            <div class="page_contact">
                <div class="container">
                    <div class="row" style="background-color: #FFDFAC">
                        <div class="col-lg-6">
                            <h2>Contact Us</h2>
                            <p>Điền nội dung tin nhắn vào form dưới đây và gửi cho chúng tôi:</p>
                            <form id="contactForm" class="mb-4">
                                <div class="mb-3">
                                    <label for="fullNameContact" class="form-label">Họ và tên</label>
                                    <input type="text" id="fullNameContact" class="form-control" required placeholder="Họ và tên*" name="name" value="${name}"/>
                                </div>
                                <div class="mb-3">
                                    <label for="emailContact" class="form-label">Email</label>
                                    <input type="email" id="emailContact" class="form-control" required placeholder="Email*" name="email" value="${email}" />
                                </div>
                                <div class="mb-3">
                                    <label for="commentContact" class="form-label">Nội dung</label>
                                    <textarea id="commentContact" class="form-control" required placeholder="Nội dung*" rows="5" name="com" value="${com}"></textarea>
                                </div>
                                <div style="display: flex; justify-content: space-between;">
                                    <input style="background-color: #FD4D62; border-color: #FD4D62" onclick="submitForm()" class="btn btn-primary" type="submit" value="Submit" />
                                    <p id="noti" style="font-weight: bold; color: red;"></p>
                                </div>
                        </div>

                        <div class="col-lg-6">
                            <h2>Thông tin liên hệ</h2>
                            <p><strong><i class="fas fa-phone"></i>&nbsp;Phone:</strong> <a href="tel:0869696272">113</a></p>
                            <p><strong><i class="fas fa-envelope"></i>&nbsp;Email:</strong> <a href="mailto:duchvhe181827@fpt.edu.vn">duchvhe181827@fpt.edu.vn</a></p>
                            <p><strong><i class="fas fa-map-marker-alt"></i> &nbsp;Address:</strong>Trường Đại học FPT Hà Nội
                                Khu Công Nghệ Cao Hòa Lạc, km 29, Đại lộ, Thăng Long, Hà Nội, Việt Nam</p>
                            <div class="map">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4558.988587803194!2d105.52225514250594!3d21.01263150080737!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1728295870061!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade" title="Address"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <script>
            function submitForm() {
                var element = document.getElementById('noti');
                element.innerText = 'Thank for your opinion';
            }
        </script>

    </body>
</html>