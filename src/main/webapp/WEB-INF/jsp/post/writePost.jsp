<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <base href="http://localhost:8080/egov11/">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="/egov11/css/post/writePost.css">
    <title>Write a Post</title>
    <script>
        $(document).ready(function() {
            $('#writePost').submit(function(e) {
                e.preventDefault(); // 기본 폼 제출 방지

                let formData = new FormData(this);
                let token = localStorage.getItem('jwtToken');

                $.ajax({
                    url: "post/writePost.do",
                    type: "POST",
                    data: formData,
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("Authorization", "Bearer " + token);
                    },
                    processData: false, // 폼 데이터를 문자열로 변환하지 않음
                    contentType: false, // 기본값은 application/x-www-form-urlencoded 파일 전송시 false로 설정
                    success: function(response) {
                        alert("게시글 작성 성공!");
                        location.href = 'post/goShowAllPosts.do';
                    },
                    error: function(xhr, status, error) {
                        alert("Error: " + error);
                        console.log(xhr.responseText);
                    }
                });
            });
        });
    </script>
</head>
<body>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
            <p><%= request.getAttribute("errorMessage") %></p>
        </div>
    <% } %>

    <div class="postForm">
        <form id="writePost" action="post/writePost.do" method="post" enctype="multipart/form-data">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required="required">
            
            <label for="content">Content:</label>
            <input type="text" id="content" name="content" required="required">
            
            <label for="uploadFile">Upload File:</label>
            <input type="file" id="uploadFile" name="uploadFile">

            <div class="buttonGroup">
                <button type="submit" class="postButton">Post</button>
                <button type="button" class="goBackButton" onclick="location.href='post/goShowAllPosts.do'">Go Back</button>
            </div>
        </form>
    </div>

</body>
</html>
